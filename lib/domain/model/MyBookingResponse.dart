import 'dart:convert';

import 'package:lab_test_app/domain/model/test.dart';
MyBookingResponse myBookingResponseFromJson(String str) => MyBookingResponse.fromJson(json.decode(str));
String myBookingResponseToJson(MyBookingResponse data) => json.encode(data.toJson());
class MyBookingResponse {
  MyBookingResponse({
      String? status, 
      List<Booking>? booking,
      String? pdfBaseURL,}){
    _status = status;
    _booking = booking;
    _pdfBaseURL = pdfBaseURL;
}

  MyBookingResponse.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _booking = [];
      json['result'].forEach((v) {
        _booking?.add(Booking.fromJson(v));
      });
    }
    _pdfBaseURL = json['pdfBaseURL'];
  }
  String? _status;
  List<Booking>? _booking;
  String? _pdfBaseURL;
MyBookingResponse copyWith({  String? status,
  List<Booking>? booking,
  String? pdfBaseURL,
}) => MyBookingResponse(  status: status ?? _status,
  booking: booking ?? _booking,
  pdfBaseURL: pdfBaseURL ?? _pdfBaseURL,
);
  String? get status => _status;
  List<Booking>? get booking => _booking;
  String? get pdfBaseURL => _pdfBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_booking != null) {
      map['result'] = _booking?.map((v) => v.toJson()).toList();
    }
    map['pdfBaseURL'] = _pdfBaseURL;
    return map;
  }

}

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));
String bookingToJson(Booking data) => json.encode(data.toJson());
class Booking {
  Booking({
      String? id, 
      String? bookingId, 
      Users? users, 
      dynamic labUser, 
      Labs? labs, 
      List<Test>? test, 
      dynamic specialist, 
      num? tax, 
      num? price, 
      num? bookingPrice,
      String? patientName,
      num? collectionType, 
      String? collectionAddress, 
      num? collectionDateUnix, 
      String? collectionSlot, 
      String? paymentGateway, 
      String? paymentGatewayTxnId, 
      String? report, 
      num? bookingStatus, 
      String? collectionDate, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _bookingId = bookingId;
    _users = users;
    _labUser = labUser;
    _labs = labs;
    _test = test;
    _bookingPrice = bookingPrice;
    _specialist = specialist;
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
    _bookingStatus = bookingStatus;
    _collectionDate = collectionDate;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Booking.fromJson(dynamic json) {
    _id = json['_id'];
    _bookingId = json['bookingId'];
    _users = json['users'] != null ? Users.fromJson(json['users']) : null;
    _labUser = json['labUser'];
    _labs = json['labs'] != null ? Labs.fromJson(json['labs']) : null;
    if (json['test'] != null) {
      _test = [];
      json['test'].forEach((v) {
        _test?.add(Test.fromJson(v));
      });
    }
    _specialist = json['specialist'];
    _tax = json['tax'];
    _price = json['price'];
    _bookingPrice = json['bookingPrice'];
    _patientName = json['patientName'];
    _collectionType = json['collectionType'];
    _collectionAddress = json['collectionAddress'];
    _collectionDateUnix = json['collectionDateUnix'];
    _collectionSlot = json['collectionSlot'];
    _paymentGateway = json['paymentGateway'];
    _paymentGatewayTxnId = json['paymentGatewayTxnId'];
    _report = json['report'];
    _bookingStatus = json['bookingStatus'];
    _collectionDate = json['collectionDate'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _bookingId;
  Users? _users;
  dynamic _labUser;
  Labs? _labs;
  List<Test>? _test;
  dynamic _specialist;
  num? _tax;
  num? _price;
  num? _bookingPrice;
  String? _patientName;
  num? _collectionType;
  String? _collectionAddress;
  num? _collectionDateUnix;
  String? _collectionSlot;
  String? _paymentGateway;
  String? _paymentGatewayTxnId;
  String? _report;
  num? _bookingStatus;
  String? _collectionDate;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Booking copyWith({  String? id,
  String? bookingId,
  Users? users,
  dynamic labUser,
  Labs? labs,
  List<Test>? test,
  dynamic specialist,
  num? tax,
  num? price,
  num? bookingPrice,
  String? patientName,
  num? collectionType,
  String? collectionAddress,
  num? collectionDateUnix,
  String? collectionSlot,
  String? paymentGateway,
  String? paymentGatewayTxnId,
  String? report,
  num? bookingStatus,
  String? collectionDate,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Booking(  id: id ?? _id,
  bookingId: bookingId ?? _bookingId,
  users: users ?? _users,
  labUser: labUser ?? _labUser,
  labs: labs ?? _labs,
  test: test ?? _test,
  specialist: specialist ?? _specialist,
  tax: tax ?? _tax,
  price: price ?? _price,
  bookingPrice: bookingPrice ?? _bookingPrice,
  patientName: patientName ?? _patientName,
  collectionType: collectionType ?? _collectionType,
  collectionAddress: collectionAddress ?? _collectionAddress,
  collectionDateUnix: collectionDateUnix ?? _collectionDateUnix,
  collectionSlot: collectionSlot ?? _collectionSlot,
  paymentGateway: paymentGateway ?? _paymentGateway,
  paymentGatewayTxnId: paymentGatewayTxnId ?? _paymentGatewayTxnId,
  report: report ?? _report,
  bookingStatus: bookingStatus ?? _bookingStatus,
  collectionDate: collectionDate ?? _collectionDate,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get bookingId => _bookingId;
  Users? get users => _users;
  dynamic get labUser => _labUser;
  Labs? get labs => _labs;
  List<Test>? get test => _test;
  dynamic get specialist => _specialist;
  num? get tax => _tax;
  num? get price => _price;
  num? get bookingPrice => _bookingPrice;
  String? get patientName => _patientName;
  num? get collectionType => _collectionType;
  String? get collectionAddress => _collectionAddress;
  num? get collectionDateUnix => _collectionDateUnix;
  String? get collectionSlot => _collectionSlot;
  String? get paymentGateway => _paymentGateway;
  String? get paymentGatewayTxnId => _paymentGatewayTxnId;
  String? get report => _report;
  num? get bookingStatus => _bookingStatus;
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
    map['labUser'] = _labUser;
    if (_labs != null) {
      map['labs'] = _labs?.toJson();
    }
    if (_test != null) {
      map['test'] = _test?.map((v) => v.toJson()).toList();
    }
    map['specialist'] = _specialist;
    map['tax'] = _tax;
    map['price'] = _price;
    map['bookingPrice'] = _bookingPrice;
    map['patientName'] = _patientName;
    map['collectionType'] = _collectionType;
    map['collectionAddress'] = _collectionAddress;
    map['collectionDateUnix'] = _collectionDateUnix;
    map['collectionSlot'] = _collectionSlot;
    map['paymentGateway'] = _paymentGateway;
    map['paymentGatewayTxnId'] = _paymentGatewayTxnId;
    map['report'] = _report;
    map['bookingStatus'] = _bookingStatus;
    map['collectionDate'] = _collectionDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

/*Test testFromJson(String str) => Test.fromJson(json.decode(str));
String testToJson(Test data) => json.encode(data.toJson());
class Test {
  Test({
      String? id, 
      String? title, 
      String? numberId,
      String? shortDesc, 
      String? desc, 
      String? thumb, 
      num? active, 
      num? deleted, 
      List<String>? slugHistory, 
      String? slug, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _title = title;
    _numberId = numberId;
    _shortDesc = shortDesc;
    _desc = desc;
    _thumb = thumb;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Test.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _numberId = json['id'];
    _shortDesc = json['shortDesc'];
    _desc = json['desc'];
    _thumb = json['thumb'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory = json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _title;
  String? _numberId;
  String? _shortDesc;
  String? _desc;
  String? _thumb;
  num? _active;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Test copyWith({  String? id,
  String? title,
  String? numberId,
  String? shortDesc,
  String? desc,
  String? thumb,
  num? active,
  num? deleted,
  List<String>? slugHistory,
  String? slug,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Test(  id: id ?? _id,
  title: title ?? _title,
  numberId: numberId ?? _numberId,
  shortDesc: shortDesc ?? _shortDesc,
  desc: desc ?? _desc,
  thumb: thumb ?? _thumb,
  active: active ?? _active,
  deleted: deleted ?? _deleted,
  slugHistory: slugHistory ?? _slugHistory,
  slug: slug ?? _slug,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get title => _title;
  String? get numberId => _numberId;
  String? get shortDesc => _shortDesc;
  String? get desc => _desc;
  String? get thumb => _thumb;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['id'] = _numberId;
    map['shortDesc'] = _shortDesc;
    map['desc'] = _desc;
    map['thumb'] = _thumb;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}*/

Labs labsFromJson(String str) => Labs.fromJson(json.decode(str));
String labsToJson(Labs data) => json.encode(data.toJson());
class Labs {
  Labs({
      Position? position, 
      String? id, 
      String? labUser, 
      String? name, 
      String? description, 
      String? email, 
      String? phone, 
      String? openFrom, 
      String? openTo, 
      String? city, 
      String? officeAddress, 
      String? image, 
      num? avgRating, 
      num? totalRating, 
      num? active, 
      num? deleted, 
      List<String>? slugHistory, 
      String? slug, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _position = position;
    _id = id;
    _labUser = labUser;
    _name = name;
    _description = description;
    _email = email;
    _phone = phone;
    _openFrom = openFrom;
    _openTo = openTo;
    _city = city;
    _officeAddress = officeAddress;
    _image = image;
    _avgRating = avgRating;
    _totalRating = totalRating;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Labs.fromJson(dynamic json) {
    _position = json['position'] != null ? Position.fromJson(json['position']) : null;
    _id = json['_id'];
    _labUser = json['labUser'];
    _name = json['name'];
    _description = json['description'];
    _email = json['email'];
    _phone = json['phone'];
    _openFrom = json['openFrom'];
    _openTo = json['openTo'];
    _city = json['city'];
    _officeAddress = json['officeAddress'];
    _image = json['image'];
    _avgRating = json['avgRating'];
    _totalRating = json['totalRating'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory = json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  Position? _position;
  String? _id;
  String? _labUser;
  String? _name;
  String? _description;
  String? _email;
  String? _phone;
  String? _openFrom;
  String? _openTo;
  String? _city;
  String? _officeAddress;
  String? _image;
  num? _avgRating;
  num? _totalRating;
  num? _active;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Labs copyWith({  Position? position,
  String? id,
  String? labUser,
  String? name,
  String? description,
  String? email,
  String? phone,
  String? openFrom,
  String? openTo,
  String? city,
  String? officeAddress,
  String? image,
  num? avgRating,
  num? totalRating,
  num? active,
  num? deleted,
  List<String>? slugHistory,
  String? slug,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Labs(  position: position ?? _position,
  id: id ?? _id,
  labUser: labUser ?? _labUser,
  name: name ?? _name,
  description: description ?? _description,
  email: email ?? _email,
  phone: phone ?? _phone,
  openFrom: openFrom ?? _openFrom,
  openTo: openTo ?? _openTo,
  city: city ?? _city,
  officeAddress: officeAddress ?? _officeAddress,
  image: image ?? _image,
  avgRating: avgRating ?? _avgRating,
  totalRating: totalRating ?? _totalRating,
  active: active ?? _active,
  deleted: deleted ?? _deleted,
  slugHistory: slugHistory ?? _slugHistory,
  slug: slug ?? _slug,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  Position? get position => _position;
  String? get id => _id;
  String? get labUser => _labUser;
  String? get name => _name;
  String? get description => _description;
  String? get email => _email;
  String? get phone => _phone;
  String? get openFrom => _openFrom;
  String? get openTo => _openTo;
  String? get city => _city;
  String? get officeAddress => _officeAddress;
  String? get image => _image;
  num? get avgRating => _avgRating;
  num? get totalRating => _totalRating;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_position != null) {
      map['position'] = _position?.toJson();
    }
    map['_id'] = _id;
    map['labUser'] = _labUser;
    map['name'] = _name;
    map['description'] = _description;
    map['email'] = _email;
    map['phone'] = _phone;
    map['openFrom'] = _openFrom;
    map['openTo'] = _openTo;
    map['city'] = _city;
    map['officeAddress'] = _officeAddress;
    map['image'] = _image;
    map['avgRating'] = _avgRating;
    map['totalRating'] = _totalRating;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

Position positionFromJson(String str) => Position.fromJson(json.decode(str));
String positionToJson(Position data) => json.encode(data.toJson());
class Position {
  Position({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  Position.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
Position copyWith({  String? type,
  List<num>? coordinates,
}) => Position(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}

Users usersFromJson(String str) => Users.fromJson(json.decode(str));
String usersToJson(Users data) => json.encode(data.toJson());
class Users {
  Users({
      String? id, 
      String? name, 
      String? mobile, 
      String? email, 
      String? image, 
      String? deviceToken, 
      String? deviceType, 
      num? active, 
      num? deleted, 
      String? refCode, 
      String? dobDate, 
      String? dobDateUnix, 
      String? createdAt, 
      String? updatedAt, 
      num? v, 
      String? panNumber, 
      String? panImage,}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _email = email;
    _image = image;
    _deviceToken = deviceToken;
    _deviceType = deviceType;
    _active = active;
    _deleted = deleted;
    _refCode = refCode;
    _dobDate = dobDate;
    _dobDateUnix = dobDateUnix;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
    _panNumber = panNumber;
    _panImage = panImage;
}

  Users.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _email = json['email'];
    _image = json['image'];
    _deviceToken = json['deviceToken'];
    _deviceType = json['deviceType'];
    _active = json['active'];
    _deleted = json['deleted'];
    _refCode = json['refCode'];
    _dobDate = json['dobDate'];
    _dobDateUnix = json['dobDateUnix'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
    _panNumber = json['panNumber'];
    _panImage = json['panImage'];
  }
  String? _id;
  String? _name;
  String? _mobile;
  String? _email;
  String? _image;
  String? _deviceToken;
  String? _deviceType;
  num? _active;
  num? _deleted;
  String? _refCode;
  String? _dobDate;
  String? _dobDateUnix;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  String? _panNumber;
  String? _panImage;
Users copyWith({  String? id,
  String? name,
  String? mobile,
  String? email,
  String? image,
  String? deviceToken,
  String? deviceType,
  num? active,
  num? deleted,
  String? refCode,
  String? dobDate,
  String? dobDateUnix,
  String? createdAt,
  String? updatedAt,
  num? v,
  String? panNumber,
  String? panImage,
}) => Users(  id: id ?? _id,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  email: email ?? _email,
  image: image ?? _image,
  deviceToken: deviceToken ?? _deviceToken,
  deviceType: deviceType ?? _deviceType,
  active: active ?? _active,
  deleted: deleted ?? _deleted,
  refCode: refCode ?? _refCode,
  dobDate: dobDate ?? _dobDate,
  dobDateUnix: dobDateUnix ?? _dobDateUnix,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
  panNumber: panNumber ?? _panNumber,
  panImage: panImage ?? _panImage,
);
  String? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get email => _email;
  String? get image => _image;
  String? get deviceToken => _deviceToken;
  String? get deviceType => _deviceType;
  num? get active => _active;
  num? get deleted => _deleted;
  String? get refCode => _refCode;
  String? get dobDate => _dobDate;
  String? get dobDateUnix => _dobDateUnix;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;
  String? get panNumber => _panNumber;
  String? get panImage => _panImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['email'] = _email;
    map['image'] = _image;
    map['deviceToken'] = _deviceToken;
    map['deviceType'] = _deviceType;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['refCode'] = _refCode;
    map['dobDate'] = _dobDate;
    map['dobDateUnix'] = _dobDateUnix;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    map['panNumber'] = _panNumber;
    map['panImage'] = _panImage;
    return map;
  }

}