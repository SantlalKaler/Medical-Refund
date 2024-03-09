import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lab_test_app/domain/model/ChatHeadsModel.dart';
import 'package:lab_test_app/domain/model/Lab.dart';
import 'package:lab_test_app/domain/model/MessageReceivedModel.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../../../data/api.dart';
import '../../../../../data/app_urls.dart';
import '../../../../../data/response_status.dart';
import '../../../../../domain/model/LabDetailsModel.dart';
import '../../../../../domain/model/MessageModel.dart';
import '../../../../../domain/model/SpecialistDetailsModel.dart';
import '../../../../../domain/model/auth/VerifyOtp.dart';
import '../../../../../domain/model/auth/user.dart';
import '../../../../../domain/model/specialist.dart';
import '../../../../base/constant.dart';
import '../../../../base/pref_data.dart';
import '../../../../base/view_utils.dart';
import '../../../controller/controller.dart';

class ChatController extends GetxController {
  RxBool loading = false.obs;

  final messageController = TextEditingController().obs;
  late Socket socket;

  //late final Map<String, dynamic> userMap;
  RxString receiverId = "".obs;
  RxString receiverType = "".obs;
  RxBool isSpecialist = false.obs;
  final userSpecialist = Rxn<Specialist>();
  RxList<MessageModel> messages = RxList();
  BottomItemSelectionController navController =
      Get.put(BottomItemSelectionController());
  final user = Rxn<User>();
  var specialistDetails = Rxn<SpecialistDetailsModel>();
  API api = API();
  var lab = Rxn<Lab>();
  var image = Rxn<String>();
  var labDetails = Rxn<LabDetailsModel>();
  var messageReceivedModel = Rxn<MessageReceivedModel>();
  var chatHeads = Rxn<ChatHeadModel>();
  var filterChatHeads = RxList<MessageReceivedModel>();
  final scrollController = ScrollController().obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  setValue(String id, String type) {
    receiverId.value = id;
    receiverType.value = type;
    Constant.printValue("Receiver id : $id\n Receiver type : $type");
    if (receiverType.value == ChatWith.lab.name) {
      getLabDetails(receiverId.value);
    } else if (receiverType.value == ChatWith.specialist.name) {
      getSpecialistDetails(receiverId.value);
    } else {
      getUserDetails(receiverId.value);
    }
  }

  searchChatHeads(String query) {
    Constant.printValue(query);
    filterChatHeads.clear();
    for (var chat in chatHeads.value?.result ?? []) {
      if (isSpecialist.value) {
        if (chat.user.name.toLowerCase().contains(query.toLowerCase())) {
          filterChatHeads.add(chat);
        }
      } else if (chat.lab != null) {
        if (chat.lab.name.toLowerCase().contains(query.toLowerCase())) {
          filterChatHeads.add(chat);
        }
      }else{
        if (chat.specialist.name.toLowerCase().contains(query.toLowerCase())) {
          filterChatHeads.add(chat);
        }
      }
    }
    filterChatHeads.value = chatHeads.value?.result?.where((profile) {
          if (isSpecialist.value) {
            return profile.users!.name!
                .toLowerCase()
                .contains(query.toLowerCase());
          } else {
            return (profile.lab != null &&
                    profile.lab!.name!
                        .toLowerCase()
                        .contains(query.toLowerCase())) ||
                (profile.specialist != null &&
                    profile.specialist!.name!
                        .toLowerCase()
                        .contains(query.toLowerCase()));
          }
        }).toList() ??
        [];
  }

  setMessage(String type, String message) {
    MessageModel msg = MessageModel(type: type, message: message);
    messages.add(msg);
    Constant.printValue(
        "Message type : $type\n Message is : $message\n message list is : $messages");
    jumpController();
    update();
  }

  // ---------------------- chat with details -----------------------------

  getLabDetails(String labId) async {
    setLoading();
    var res = await api.getRequest(AppUrls.labDetails, {"id": labId});

    setLoading();
    labDetails.value = LabDetailsModel.fromJson(res);
    if (labDetails.value!.status == Status.success.name) {
      lab.value = labDetails.value!.result!.detail;
      image.value = "${AppUrls.imageBaseUrl}${lab.value!.image}";
      getChatHistory();
      connect();
      update();
    } else {
      showSnackbar("Message", "Something went wrong. Try again later");
      Constant.backToPrev();
    }
  }

  getUserDetails(String id) async {
    setLoading();
    var res = await api.getRequest(AppUrls.details, {"id": id});

    setLoading();
    var verifyOtp = VerifyOtp.fromJson(res);
    if (verifyOtp.status == Status.success.name) {
      user.value = verifyOtp.user;
      getChatHistory();
      connect();
      update();
    } else {
      showSnackbar("Message", "Something went wrong. Try again later");
      Constant.backToPrev();
    }
  }

  getSpecialistDetails(String specialistId) async {
    setLoading();
    var res =
        await api.getRequest(AppUrls.specialistDetail, {"id": specialistId});

    specialistDetails.value = SpecialistDetailsModel.fromJson(res);
    setLoading();
    if (specialistDetails.value!.status != Status.success.name) {
      showSnackbar("Message", "Something went wrong. Try again later");
      Constant.backToPrev();
    } else {
      //specialist.value = specialistDetails.value!.result!.detail;
      getChatHistory();
      connect();
    }
    update();
  }

  getChatHeads() async {
    setLoading();
    var data = isSpecialist.value
        ? {"specialist": userSpecialist.value!.id}
        : {"user": user.value!.id};
    var res = await api.getRequest(AppUrls.chatHeads, data);

    chatHeads.value = ChatHeadModel.fromJson(res);
    setLoading();
    update();
  }

  getChatHistory() async {
    setLoading();
    var data = isSpecialist.value
        ? {"user": receiverId, "specialist": userSpecialist.value!.id}
        : receiverType.value == ChatWith.specialist.name
            ? {
                "user": user.value!.id,
                "specialist": specialistDetails.value!.result!.detail!.id
              }
            : {"user": user.value!.id, "lab": lab.value!.id};
    var res = await api.getRequest(AppUrls.chatHistory, data);

    chatHeads.value = ChatHeadModel.fromJson(res);
    setLoading();

    if (chatHeads.value!.result!.isNotEmpty) {
      for (var chat in chatHeads.value!.result!) {
        if (isSpecialist.value) {
          if (chat.sender == "specialist") {
            setMessage("send", chat.message!);
          } else {
            setMessage("receiver", chat.message!);
          }
        } else {
          if (chat.sender == "user") {
            setMessage("send", chat.message!);
          } else {
            setMessage("receiver", chat.message!);
          }
        }
      }
    }
    update();
  }

  // ---------------------- chat -----------------------------

  void connect() {
    socket = io("https://socket.medicalrefund.in/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();

    socket.onConnect(
      (data) => {
        Constant.printValue("Connected"),
        joinRoom(),
      },
    );
    socket.on(
        "receive",
        (data) => {
              Constant.printValue("Receive data  is : $data"),
              if (data != null)
                {
                  messageReceivedModel.value =
                      MessageReceivedModel.fromJson(data),
                  setMessage("receiver", messageReceivedModel.value!.message!)
                }
            });

    socket.onDisconnect((data) => {Constant.printValue("DisConnected")});
    socket.onError(
        (data) => {Constant.printValue("Getting error : \n error is : $data")});
  }

  joinRoom() {
    var roomData = isSpecialist.value
        ? {
            "senderId": userSpecialist.value?.id,
            "senderType": "specialist",
            "receiverId": receiverId.value,
            "receiverType": "user",
          }
        : {
            "senderId": user.value?.id,
            "senderType": "user",
            "receiverId": receiverId.value,
            "receiverType": receiverType.value,
          };

    socket.emit("join", roomData);
    Constant.printValue("Join room : $roomData");

    socket.on("join", (data) => {Constant.printValue(data)});
  }

  jumpController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.value
          .jumpTo(scrollController.value.position.maxScrollExtent);
    });
  }

  isLoading() {
    loading.value = !loading.value;
    update();
  }

  getUser() async {
    setLoading();
    isSpecialist.value = await PrefData.getIsSpecialist();
    if (isSpecialist.value) {
      userSpecialist.value = await PrefData.getUserSpecialist();
      Constant.printValue(userSpecialist.value);
    } else {
      user.value = await PrefData.getUser();
      Constant.printValue("user id is : ${user.value?.id}");
    }
    if (receiverType.value == "") {
      getChatHeads();
    }
    setLoading();
    update();
  }

  void onSendMessage() {
    Constant.printValue(
        "senderId : ${isSpecialist.value ? userSpecialist.value!.id : user.value!.id}\n"
        "receiverId : ${receiverId.value}\n"
        "receiverType : ${receiverType.value}\n"
        "senderType : ${isSpecialist.value ? "specialist" : "user"}\n"
        "message : ${messageController.value.text}\n");

    socket.emit("send", {
      "senderId":
          isSpecialist.value ? userSpecialist.value!.id : user.value!.id,
      "receiverId": receiverId.value,
      "receiverType": receiverType.value,
      "senderType": isSpecialist.value ? "specialist" : "user",
      "message": messageController.value.text
    });
    setMessage("send", messageController.value.text);
    messageController.value.text = "";
  }
}
