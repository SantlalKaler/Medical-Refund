import 'package:get/get.dart';
import 'package:lab_test_app/data/app_urls.dart';
import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/presentation/base/constant.dart';

import '../../../../../data/api.dart';
import '../../../../../domain/model/BookingModel.dart';
import '../../../../../domain/model/MyBookingResponse.dart';
import '../../../../../domain/model/auth/user.dart';
import '../../../../base/pref_data.dart';

class BookingController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  final user = Rxn<User>();
  final specialist = Rxn<Specialist>();
  var report = Rxn<Result>();

  var myBookingResponse = Rxn<MyBookingResponse>();
  RxList<Booking> myBookings = RxList();
  RxList<Booking> myHomeVisitBookings = RxList();
  RxList<Booking> myLabVisitBookings = RxList();

  var bookingResponse = Rxn<BookingModel>();
  List<Result> homeVisit = [];
  List<Result> bookings = [];
  List<Result> labVisit = [];

  RxBool loading = false.obs;
  RxBool isSpecialist = false.obs;
  API api = API();

  setLoading() {
    loading.value = !loading.value;
    update();
  }

  setSelectedText(index) {
    report.value = bookings[index];
    update();
  }

  getUser() async {
    isSpecialist.value = await PrefData.getIsSpecialist();
    if (isSpecialist.value) {
      specialist.value = await PrefData.getUserSpecialist();
      Constant.printValue(specialist.value);
    } else {
      user.value = await PrefData.getUser();
      Constant.printValue(user.value);
    }
    getBookings(
        isSpecialist.value ? specialist.value!.id! : user.value!.id.toString());
    update();
  }

  getBookings(String userId) async {
    setLoading();
    var res = await api.getRequest(
        isSpecialist.value ? AppUrls.specialistBookings : AppUrls.myBookings,
        {"id": userId});
    /*bookingResponse.value = BookingModel.fromJson(res);
    bookings = bookingResponse.value!.result!;*/

    if (res != null) {
      myBookingResponse.value = MyBookingResponse.fromJson(res);
      if (myBookingResponse.value!.status == "success" &&
          myBookingResponse.value!.booking!.isNotEmpty) {
        myBookings.value = myBookingResponse.value!.booking!;

        for(var boking in myBookings){
          if(boking.collectionType == 1){
            myHomeVisitBookings.add(boking);
          }else{
            myLabVisitBookings.add(boking);
          }
        }
      }
    }

   /* if (bookings.isNotEmpty) {
      for (var booking in bookings) {
        if (booking.collectionType == 1) {
          homeVisit.add(booking);
        } else {
          labVisit.add(booking);
        }
      }
    }*/

    Constant.printValue("Booking Response : $myBookingResponse\n"
        "bookings : ${myBookings.length}\n"
        "Homevisit : ${myHomeVisitBookings.length}\n"
        "Labvisit : ${myLabVisitBookings.length}\n");

    setLoading();
    update();
  }
}
