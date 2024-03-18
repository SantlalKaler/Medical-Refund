import 'package:lab_test_app/domain/model/review.dart';
import 'package:lab_test_app/domain/model/test.dart';

import 'Lab.dart';

class LabDetailsModel {
  LabDetailsModel({
    String? status,
    Result? result,
  }) {
    _status = status;
    _result = result;
  }

  LabDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  Result? _result;
  LabDetailsModel copyWith({
    String? status,
    Result? result,
  }) =>
      LabDetailsModel(
        status: status ?? _status,
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

class Result {
  Result({
    Lab? detail,
    List<Tests>? tests,
    List<Reviews>? reviews,
    String? imgBaseURL,
  }) {
    _detail = detail;
    _tests = tests;
    _reviews = reviews;
    _imgBaseURL = imgBaseURL;
  }

  Result.fromJson(dynamic json) {
    _detail = json['detail'] != null ? Lab.fromJson(json['detail']) : null;
    if (json['tests'] != null) {
      _tests = [];
      json['tests'].forEach((v) {
        _tests?.add(Tests.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      _reviews = [];
      json['reviews'].forEach((v) {
        _reviews?.add(Reviews.fromJson(v));
      });
    }
    //_reviews = json['reviews'] != null ? Reviews.fromJson(json['reviews']) : null;
    _imgBaseURL = json['imgBaseURL'];
  }
  Lab? _detail;
  List<Tests>? _tests;
  List<Reviews>? _reviews;
  String? _imgBaseURL;
  Result copyWith({
    Lab? detail,
    List<Tests>? tests,
    List<Reviews>? reviews,
    String? imgBaseURL,
  }) =>
      Result(
        detail: detail ?? _detail,
        tests: tests ?? _tests,
        reviews: reviews ?? _reviews,
        imgBaseURL: imgBaseURL ?? _imgBaseURL,
      );
  Lab? get detail => _detail;
  List<Tests>? get tests => _tests;
  List<Reviews>? get reviews => _reviews;
  String? get imgBaseURL => _imgBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.toJson();
    }
    if (_tests != null) {
      map['tests'] = _tests?.map((v) => v.toJson()).toList();
    }
    if (_reviews != null) {
      map['reviews'] = _reviews?.map((v) => v.toJson()).toList();
      // map['reviews'] = _reviews?.toJson();
    }
    map['imgBaseURL'] = _imgBaseURL;
    return map;
  }
}

class Tests {
  Tests({
    String? id,
    String? title,
    String? labs,
    Test? test,
    num? priceBefore,
    num? price,
    num? bookingPrice,
    num? adminCommission,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _title = title;
    _labs = labs;
    _test = test;
    _bookingPrice = bookingPrice;
    _priceBefore = priceBefore;
    _price = price;
    _adminCommission = adminCommission;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Tests.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _labs = json['labs'];
    _bookingPrice = json['bookingPrice'];
    _test = json['test'] != null ? Test.fromJson(json['test']) : null;
    _priceBefore = json['priceBefore'];
    _price = json['price'];
    _adminCommission = json['adminCommission'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _title;
  String? _labs;
  Test? _test;
  num? _priceBefore;
  num? _bookingPrice;
  num? _price;
  num? _adminCommission;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Tests copyWith({
    String? id,
    String? labs,
    Test? test,
    num? priceBefore,
    num? bookingPrice,
    num? price,
    num? adminCommission,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Tests(
        id: id ?? _id,
        title: title ?? _title,
        labs: labs ?? _labs,
        bookingPrice: bookingPrice ?? _bookingPrice,
        test: test ?? _test,
        priceBefore: priceBefore ?? _priceBefore,
        price: price ?? _price,
        adminCommission: adminCommission ?? _adminCommission,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get id => _id;
  String? get title => _title;
  String? get labs => _labs;
  Test? get test => _test;
  num? get bookingPrice => _bookingPrice;
  num? get priceBefore => _priceBefore;
  num? get price => _price;
  num? get adminCommission => _adminCommission;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['labs'] = _labs;
    map['bookingPrice'] = _bookingPrice;
    if (_test != null) {
      map['test'] = _test?.toJson();
    }
    map['priceBefore'] = _priceBefore;
    map['price'] = _price;
    map['adminCommission'] = _adminCommission;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
