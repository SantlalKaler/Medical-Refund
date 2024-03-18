import 'package:flutter/cupertino.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfdropcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentcomponents/cfpaymentcomponent.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/api/cftheme/cftheme.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfexceptions.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/data/response_status.dart';
import 'package:lab_test_app/domain/model/CommonModel.dart';
import 'package:lab_test_app/domain/model/LabDetailsModel.dart';
import 'package:lab_test_app/domain/model/TestDetailModel.dart';
import 'package:lab_test_app/domain/model/auth/user.dart';
import 'package:lab_test_app/domain/model/Lab.dart';
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/presentation/app/routes/app_routes.dart';
import 'package:lab_test_app/presentation/app/screen/lists/labDetail/lab_controller.dart';
import 'package:lab_test_app/presentation/base/constant.dart';
import 'package:lab_test_app/presentation/base/pref_data.dart';
import 'package:lab_test_app/presentation/base/view_utils.dart';

import '../../../../../data/api.dart';
import '../../../../../domain/model/CreatePaymentModel.dart';

class AddBookingController extends GetxController {
  CFPaymentGatewayService cfPaymentGatewayService = CFPaymentGatewayService();

  var user = Rxn<User>();

  var test = Rxn<Tests>();
  var lab = Rxn<Lab>();
  var priceList = Rxn<PriceList>();
  RxBool multiTests = false.obs;
  RxInt selectedPos = 0.obs;
  RxInt testAdminCommission = 0.obs;

  var specialist = Rxn<Specialist>();

  var createPaymentModel = Rxn<CreatePaymentModel>();

  final dateController = TextEditingController().obs;
  final timeController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final addressController = TextEditingController().obs;

  RxBool loading = false.obs;
  API api = API();

  @override
  void onInit() {
    getUser();
    cfPaymentGatewayService.setCallback(verifyPayment, onError, receivedEvent);
    super.onInit();
  }

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  getSpecialist(Specialist value) {
    specialist.value = value;
    update();
  }

  getUser() async {
    user.value = await PrefData.getUser();
    update();
  }

  createPayment(bookingAmount) async {
    print('object==>>>$bookingAmount');

    setLoading();
    var payload = {'amount': bookingAmount, 'customer_id': user.value!.id!};
    var res = await api.postRequest(AppUrls.createPayment, payload);
    createPaymentModel.value = CreatePaymentModel.fromJson(res);
    setLoading();

    if (createPaymentModel.value?.result != null) {
      var orderId = createPaymentModel.value!.result!.orderId;
      var paymentSessionId =
          createPaymentModel.value!.result!.paymentSessionId!;
      pay(orderId, paymentSessionId);
    } else {
      showSnackbar('Message', createPaymentModel.value!.message);
    }
    update();
  }

  addBooking() async {
      LabController labController = Get.find();
    var testId = "";
    var labId = "";
    num multiTestLabPrice = 0;
    if (multiTests.isTrue) {
      labId = labController.lab.value!.id!;

      List<String> testIds = [];
      for (var test in labController.selectedTests) {
        testIds.add(test.test!.id!);
        multiTestLabPrice += test.price!;
      }
      testId = testIds.length > 1 ? testIds.join(",") : testIds.first;
    }else{
      testId = test.value!.test!.id!;
      labId = priceList.value?.labId ?? lab.value!.id!;
    }

    var ids = specialist.value == null
        ? {
            "lab": labId,
            "test": testId,
          }
        : {'specialist': specialist.value!.id};

    var params = {
      ...ids,
      "user": user.value!.id!,
      "tax": '5',
      'price': (specialist.value != null)
          ? specialist.value!.price!
          : (priceList.value != null)
              ? priceList.value!.price
              : multiTests.isTrue
          ? multiTestLabPrice
          :test.value!.price!,
      'patientName': user.value?.name ?? "",
      'collectionType': selectedPos.value.toString(),
      'collectionAddress':
          selectedPos.value == 0 ? "" : addressController.value.text,
      'collectionDate': Constant.changeDateFormat(
          selectedPos.value == 0
              ? DateTime.now().toString()
              : dateController.value.text,
          upload: true,
          format: selectedPos.value == 0 ? 'yyyy-MM-dd hh:mm' : 'dd MMM yyyy'),
      'collectionSlot': selectedPos.value == 0
          ? Constant.changeDateFormat(DateTime.now().toString(),
              changeInto: "hh:mm")
          : timeController.value.text,
      'paymentGateway': 'CashFree',
      'paymentGatewayTxnId':
          createPaymentModel.value!.result!.paymentSessionId!,
      'orderid': createPaymentModel.value!.result!.orderId
    };

    try {
      setLoading();
      var res = await api.postRequest(AppUrls.addBooking, params);
      var commonResponse = CommonModel.fromJson(res);
      showSnackbar('Message', commonResponse.message);
      if (commonResponse.status == Status.success.name) {
        Constant.moveToNextAndReplace(Routes.homeScreenRoute);
      }
    } finally {
      setLoading();
    }
  }

  //--------------------------- Payment Gateway ------------------------

  void verifyPayment(String orderId) {
    Constant.printValue("Verify Payment");
    showSnackbar(
        "Payment Success", "Your payment has been successfully received.");
    addBooking();
  }

  void onError(CFErrorResponse errorResponse, String orderId) {
    showSnackbar("Error in payment", errorResponse.getMessage());
    Constant.printValue(
        "Error while making payment : ${errorResponse.getMessage()}");
  }

  void receivedEvent(String eventName, Map<dynamic, dynamic> metaData) {
    Constant.printValue("Payment Received event name : $eventName");
    Constant.printValue("Payment Received meta data : $metaData");
  }

  CFSession? createSession(orderId, paymentSessionId) {
    CFEnvironment environment = CFEnvironment.PRODUCTION;
    // Constant.printValue("Session id is : $paymentSessionId");
    try {
      var session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(paymentSessionId)
          .build();
      return session;
    } on CFException catch (e) {
      Constant.printValue((e.message));
    }
    return null;
  }

  pay(orderId, paymentSessionId) async {
    try {
      var session = createSession(orderId, paymentSessionId);
      List<CFPaymentModes> components = <CFPaymentModes>[];
      components.add(CFPaymentModes.UPI);
      components.add(CFPaymentModes.CARD);
      components.add(CFPaymentModes.WALLET);

      var paymentComponent =
          CFPaymentComponentBuilder().setComponents(components).build();

      var theme = CFThemeBuilder()
          .setNavigationBarBackgroundColorColor("#128C7E")
          .setPrimaryFont("Menlo")
          .setSecondaryFont("Futura")
          .build();

      var cfDropCheckoutPayment = CFDropCheckoutPaymentBuilder()
          .setSession(session!)
          .setPaymentComponent(paymentComponent)
          .setTheme(theme)
          .build();

      cfPaymentGatewayService.doPayment(cfDropCheckoutPayment);
    } on CFException catch (e) {
      Constant.printValue((e.message));
    }
  }

  webCheckout(orderId, paymentSessionId) async {
    try {
      var session = createSession(orderId, paymentSessionId);
      var cfWebCheckout =
          CFWebCheckoutPaymentBuilder().setSession(session!).build();
      cfPaymentGatewayService.doPayment(cfWebCheckout);
    } on CFException catch (e) {
      Constant.printValue((e.message));
    }
  }
}
