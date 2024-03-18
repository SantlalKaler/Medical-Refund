import 'dart:convert';

import 'test.dart';
TestDetailModel testDetailModelFromJson(String str) => TestDetailModel.fromJson(json.decode(str));
String testDetailModelToJson(TestDetailModel data) => json.encode(data.toJson());
class TestDetailModel {
  TestDetailModel({
      String? status, 
      Result? result,}){
    _status = status;
    _result = result;
}

  TestDetailModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  Result? _result;
TestDetailModel copyWith({  String? status,
  Result? result,
}) => TestDetailModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      Test? test, 
      List<PriceList>? priceList,}){
    _test = test;
    _priceList = priceList;
}

  Result.fromJson(dynamic json) {
    _test = json['test'] != null ? Test.fromJson(json['test']) : null;
    if (json['priceList'] != null) {
      _priceList = [];
      json['priceList'].forEach((v) {
        _priceList?.add(PriceList.fromJson(v));
      });
    }
  }
  Test? _test;
  List<PriceList>? _priceList;
Result copyWith({  Test? test,
  List<PriceList>? priceList,
}) => Result(  test: test ?? _test,
  priceList: priceList ?? _priceList,
);
  Test? get test => _test;
  List<PriceList>? get priceList => _priceList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_test != null) {
      map['test'] = _test?.toJson();
    }
    if (_priceList != null) {
      map['priceList'] = _priceList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

PriceList priceListFromJson(String str) => PriceList.fromJson(json.decode(str));
String priceListToJson(PriceList data) => json.encode(data.toJson());
class PriceList {
  PriceList({
      String? labName, 
      String? officeAddress, 
      String? labImage, 
      num? price, 
      num? priceBefore, 
      num? bookingPrice,
      num? adminCommission,
      String? labId,}){
    _labName = labName;
    _officeAddress = officeAddress;
    _labImage = labImage;
    _price = price;
    _bookingPrice = bookingPrice;
    _priceBefore = priceBefore;
    _adminCommission = adminCommission;
    _labId = labId;
}

  PriceList.fromJson(dynamic json) {
    _labName = json['labName'];
    _officeAddress = json['officeAddress'];
    _labImage = json['labImage'];
    _price = json['price'];
    _bookingPrice = json['bookingPrice'];
    _priceBefore = json['priceBefore'];
    _adminCommission = json['adminCommission'];
    _labId = json['labId'];
  }
  String? _labName;
  String? _officeAddress;
  String? _labImage;
  num? _price;
  num? _bookingPrice;
  num? _priceBefore;
  num? _adminCommission;
  String? _labId;
PriceList copyWith({  String? labName,
  String? officeAddress,
  String? labImage,
  num? price,
  num? priceBefore,
  num? adminCommission,
  String? labId,
}) => PriceList(  labName: labName ?? _labName,
  officeAddress: officeAddress ?? _officeAddress,
  labImage: labImage ?? _labImage,
  price: price ?? _price,
  bookingPrice: bookingPrice ?? _bookingPrice,
  priceBefore: priceBefore ?? _priceBefore,
  adminCommission: adminCommission ?? _adminCommission,
  labId: labId ?? _labId,
);
  String? get labName => _labName;
  String? get officeAddress => _officeAddress;
  String? get labImage => _labImage;
  num? get price => _price;
  num? get bookingPrice => _bookingPrice;
  num? get priceBefore => _priceBefore;
  num? get adminCommission => _adminCommission;
  String? get labId => _labId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['labName'] = _labName;
    map['officeAddress'] = _officeAddress;
    map['labImage'] = _labImage;
    map['price'] = _price;
    map['bookingPrice'] = _bookingPrice;
    map['priceBefore'] = _priceBefore;
    map['adminCommission'] = _adminCommission;
    map['labId'] = _labId;
    return map;
  }

}
