/*
import 'dart:convert';

import 'package:lab_test_app/domain/model/test.dart';

import 'auth/user.dart';
import 'Lab.dart';
BookingModel bookingModelFromJson(String str) => BookingModel.fromJson(json.decode(str));
String bookingModelToJson(BookingModel data) => json.encode(data.toJson());
class BookingModel {
  BookingModel({
      String? status, 
      Result? result, 
      String? pdfBaseURL,}){
    _status = status;
    _result = result;
    _pdfBaseURL = pdfBaseURL;
}

  BookingModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
    _pdfBaseURL = json['pdfBaseURL'];
  }
  String? _status;
  Result? _result;
  String? _pdfBaseURL;
BookingModel copyWith({  String? status,
  Result? result,
  String? pdfBaseURL,
}) => BookingModel(  status: status ?? _status,
  result: result ?? _result,
  pdfBaseURL: pdfBaseURL ?? _pdfBaseURL,
);
  String? get status => _status;
  Result? get result => _result;
  String? get pdfBaseURL => _pdfBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    map['pdfBaseURL'] = _pdfBaseURL;
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? id, 
      String? bookingId, 
      User? users,
      Lab? labs,
      Test? test, 
      num? tax, 
      num? price, 
      String? patientName, 
      num? collectionType, 
      String? collectionAddress, 
      num? collectionDateUnix, 
      String? collectionSlot, 
      String? paymentGateway, 
      String? paymentGatewayTxnId, 
      String? report, 
      String? collectionDate, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _bookingId = bookingId;
    _users = users;
    _labs = labs;
    _test = test;
    _tax = tax;
    _price = price;
    _patientName = patientName;
    _collectionType = collectionType;
    _collectionAddress = collectionAddress;
    _collectionDateUnix = collectionDateUnix;
    _collectionSlot = collectionSlot;
    _paymentGateway = paymentGateway;
    _paymentGatewayTxnId = paymentGatewayTxnId;
    _report = report;
    _collectionDate = collectionDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _bookingId = json['bookingId'];
    _users = json['users'] != null ? User.fromJson(json['users']) : null;
    _labs = json['labs'] != null ? Lab.fromJson(json['labs']) : null;
    _test = json['test'] != null ? Test.fromJson(json['test']) : null;
    _tax = json['tax'];
    _price = json['price'];
    _patientName = json['patientName'];
    _collectionType = json['collectionType'];
    _collectionAddress = json['collectionAddress'];
    _collectionDateUnix = json['collectionDateUnix'];
    _collectionSlot = json['collectionSlot'];
    _paymentGateway = json['paymentGateway'];
    _paymentGatewayTxnId = json['paymentGatewayTxnId'];
    _report = json['report'];
    _collectionDate = json['collectionDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _bookingId;
  User? _users;
  Lab? _labs;
  Test? _test;
  num? _tax;
  num? _price;
  String? _patientName;
  num? _collectionType;
  String? _collectionAddress;
  num? _collectionDateUnix;
  String? _collectionSlot;
  String? _paymentGateway;
  String? _paymentGatewayTxnId;
  String? _report;
  String? _collectionDate;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Result copyWith({  String? id,
  String? bookingId,
  User? users,
  Lab? labs,
  Test? test,
  num? tax,
  num? price,
  String? patientName,
  num? collectionType,
  String? collectionAddress,
  num? collectionDateUnix,
  String? collectionSlot,
  String? paymentGateway,
  String? paymentGatewayTxnId,
  String? report,
  String? collectionDate,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Result(  id: id ?? _id,
  bookingId: bookingId ?? _bookingId,
  users: users ?? _users,
  labs: labs ?? _labs,
  test: test ?? _test,
  tax: tax ?? _tax,
  price: price ?? _price,
  patientName: patientName ?? _patientName,
  collectionType: collectionType ?? _collectionType,
  collectionAddress: collectionAddress ?? _collectionAddress,
  collectionDateUnix: collectionDateUnix ?? _collectionDateUnix,
  collectionSlot: collectionSlot ?? _collectionSlot,
  paymentGateway: paymentGateway ?? _paymentGateway,
  paymentGatewayTxnId: paymentGatewayTxnId ?? _paymentGatewayTxnId,
  report: report ?? _report,
  collectionDate: collectionDate ?? _collectionDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get bookingId => _bookingId;
  User? get users => _users;
  Lab? get labs => _labs;
  Test? get test => _test;
  num? get tax => _tax;
  num? get price => _price;
  String? get patientName => _patientName;
  num? get collectionType => _collectionType;
  String? get collectionAddress => _collectionAddress;
  num? get collectionDateUnix => _collectionDateUnix;
  String? get collectionSlot => _collectionSlot;
  String? get paymentGateway => _paymentGateway;
  String? get paymentGatewayTxnId => _paymentGatewayTxnId;
  String? get report => _report;
  String? get collectionDate => _collectionDate;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['bookingId'] = _bookingId;
    if (_users != null) {
      map['users'] = _users?.toJson();
    }
    if (_labs != null) {
      map['labs'] = _labs?.toJson();
    }
    if (_test != null) {
      map['test'] = _test?.toJson();
    }
    map['tax'] = _tax;
    map['price'] = _price;
    map['patientName'] = _patientName;
    map['collectionType'] = _collectionType;
    map['collectionAddress'] = _collectionAddress;
    map['collectionDateUnix'] = _collectionDateUnix;
    map['collectionSlot'] = _collectionSlot;
    map['paymentGateway'] = _paymentGateway;
    map['paymentGatewayTxnId'] = _paymentGatewayTxnId;
    map['report'] = _report;
    map['collectionDate'] = _collectionDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}
*/

import 'dart:convert';

import 'package:lab_test_app/domain/model/specialist.dart';
import 'package:lab_test_app/domain/model/test.dart';

import 'auth/user.dart';
import 'Lab.dart';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

String bookingModelToJson(BookingModel data) =>
    json.encode(data.toJson());

class BookingModel {
  BookingModel({
    String? status,
    List<Result>? result,
    String? pdfBaseURL,
  }) {
    _status = status;
    _result = result;
    _pdfBaseURL = pdfBaseURL;
  }

  BookingModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
    _pdfBaseURL = json['pdfBaseURL'];
  }

  String? _status;
  List<Result>? _result;
  String? _pdfBaseURL;

  BookingModel copyWith({
    String? status,
    List<Result>? result,
    String? pdfBaseURL,
  }) =>
      BookingModel(
        status: status ?? _status,
        result: result ?? _result,
        pdfBaseURL: pdfBaseURL ?? _pdfBaseURL,
      );

  String? get status => _status;

  List<Result>? get result => _result;

  String? get pdfBaseURL => _pdfBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['pdfBaseURL'] = _pdfBaseURL;
    return map;
  }
}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    String? id,
    String? bookingId,
    User? users,
    Lab? labs,
    Specialist? specialist,
    Test? test,
    num? tax,
    num? price,
    String? patientName,
    num? collectionType,
    String? collectionAddress,
    num? collectionDateUnix,
    String? collectionSlot,
    String? paymentGateway,
    String? paymentGatewayTxnId,
    String? report,
    String? collectionDate,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _bookingId = bookingId;
    _users = users;
    _labs = labs;
    _specialist = specialist;
    _test = test;
    _tax = tax;
    _price = price;
    _patientName = patientName;
    _collectionType = collectionType;
    _collectionAddress = collectionAddress;
    _collectionDateUnix = collectionDateUnix;
    _collectionSlot = collectionSlot;
    _paymentGateway = paymentGateway;
    _paymentGatewayTxnId = paymentGatewayTxnId;
    _report = report;
    _collectionDate = collectionDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _bookingId = json['bookingId'];
    _users = json['users'] != null ? User.fromJson(json['users']) : null;
    _labs = json['labs'] != null ? Lab.fromJson(json['labs']) : null;
    _specialist = json['specialist'] != null ? Specialist.fromJson(json['specialist']) : null;
    _test = json['test'] != null ? Test.fromJson(json['test']) : null;
    _tax = json['tax'];
    _price = json['price'];
    _patientName = json['patientName'];
    _collectionType = json['collectionType'];
    _collectionAddress = json['collectionAddress'];
    _collectionDateUnix = json['collectionDateUnix'];
    _collectionSlot = json['collectionSlot'];
    _paymentGateway = json['paymentGateway'];
    _paymentGatewayTxnId = json['paymentGatewayTxnId'];
    _report = json['report'];
    _collectionDate = json['collectionDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }

  String? _id;
  String? _bookingId;
  User? _users;
  Lab? _labs;
  Specialist? _specialist;
  Test? _test;
  num? _tax;
  num? _price;
  String? _patientName;
  num? _collectionType;
  String? _collectionAddress;
  num? _collectionDateUnix;
  String? _collectionSlot;
  String? _paymentGateway;
  String? _paymentGatewayTxnId;
  String? _report;
  String? _collectionDate;
  String? _createdAt;
  String? _updatedAt;
  num? _v;

  Result copyWith({
    String? id,
    String? bookingId,
    User? users,
    Lab? labs,
    Specialist? specialist,
    Test? test,
    num? tax,
    num? price,
    String? patientName,
    num? collectionType,
    String? collectionAddress,
    num? collectionDateUnix,
    String? collectionSlot,
    String? paymentGateway,
    String? paymentGatewayTxnId,
    String? report,
    String? collectionDate,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Result(
        id: id ?? _id,
        bookingId: bookingId ?? _bookingId,
        users: users ?? _users,
        labs: labs ?? _labs,
        specialist: specialist ?? _specialist,
        test: test ?? _test,
        tax: tax ?? _tax,
        price: price ?? _price,
        patientName: patientName ?? _patientName,
        collectionType: collectionType ?? _collectionType,
        collectionAddress: collectionAddress ?? _collectionAddress,
        collectionDateUnix: collectionDateUnix ?? _collectionDateUnix,
        collectionSlot: collectionSlot ?? _collectionSlot,
        paymentGateway: paymentGateway ?? _paymentGateway,
        paymentGatewayTxnId: paymentGatewayTxnId ?? _paymentGatewayTxnId,
        report: report ?? _report,
        collectionDate: collectionDate ?? _collectionDate,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );

  String? get id => _id;

  String? get bookingId => _bookingId;

  User? get users => _users;

  Lab? get labs => _labs;
  Specialist? get specialist => _specialist;

  Test? get test => _test;

  num? get tax => _tax;

  num? get price => _price;

  String? get patientName => _patientName;

  num? get collectionType => _collectionType;

  String? get collectionAddress => _collectionAddress;

  num? get collectionDateUnix => _collectionDateUnix;

  String? get collectionSlot => _collectionSlot;

  String? get paymentGateway => _paymentGateway;

  String? get paymentGatewayTxnId => _paymentGatewayTxnId;

  String? get report => _report;

  String? get collectionDate => _collectionDate;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['bookingId'] = _bookingId;
    if (_users != null) {
      map['users'] = _users?.toJson();
    }
    if (_labs != null) {
      map['labs'] = _labs?.toJson();
    }
    if (_specialist != null) {
      map['specialist'] = _specialist?.toJson();
    }
    if (_test != null) {
      map['test'] = _test?.toJson();
    }
    map['tax'] = _tax;
    map['price'] = _price;
    map['patientName'] = _patientName;
    map['collectionType'] = _collectionType;
    map['collectionAddress'] = _collectionAddress;
    map['collectionDateUnix'] = _collectionDateUnix;
    map['collectionSlot'] = _collectionSlot;
    map['paymentGateway'] = _paymentGateway;
    map['paymentGatewayTxnId'] = _paymentGatewayTxnId;
    map['report'] = _report;
    map['collectionDate'] = _collectionDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
