import 'dart:convert';
WalletModel walletModelFromJson(String str) => WalletModel.fromJson(json.decode(str));
String walletModelToJson(WalletModel data) => json.encode(data.toJson());
class WalletModel {
  WalletModel({
      String? status, 
      String? message, 
      Result? result,}){
    _status = status;
    _message = message;
    _result = result;
}

  WalletModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  Result? _result;
WalletModel copyWith({  String? status,
  String? message,
  Result? result,
}) => WalletModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
);
  String? get status => _status;
  String? get message => _message;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
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
      num? totalAmount, 
      num? totalPages, 
      String? currentPage, 
      String? pageSize, 
      List<Transactions>? transactions,}){
    _totalAmount = totalAmount;
    _totalPages = totalPages;
    _currentPage = currentPage;
    _pageSize = pageSize;
    _transactions = transactions;
}

  Result.fromJson(dynamic json) {
    _totalAmount = json['totalAmount'];
    _totalPages = json['totalPages'];
    _currentPage = json['currentPage'];
    _pageSize = json['pageSize'];
    if (json['transactions'] != null) {
      _transactions = [];
      json['transactions'].forEach((v) {
        _transactions?.add(Transactions.fromJson(v));
      });
    }
  }
  num? _totalAmount;
  num? _totalPages;
  String? _currentPage;
  String? _pageSize;
  List<Transactions>? _transactions;
Result copyWith({  num? totalAmount,
  num? totalPages,
  String? currentPage,
  String? pageSize,
  List<Transactions>? transactions,
}) => Result(  totalAmount: totalAmount ?? _totalAmount,
  totalPages: totalPages ?? _totalPages,
  currentPage: currentPage ?? _currentPage,
  pageSize: pageSize ?? _pageSize,
  transactions: transactions ?? _transactions,
);
  num? get totalAmount => _totalAmount;
  num? get totalPages => _totalPages;
  String? get currentPage => _currentPage;
  String? get pageSize => _pageSize;
  List<Transactions>? get transactions => _transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalAmount'] = _totalAmount;
    map['totalPages'] = _totalPages;
    map['currentPage'] = _currentPage;
    map['pageSize'] = _pageSize;
    if (_transactions != null) {
      map['transactions'] = _transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Transactions transactionsFromJson(String str) => Transactions.fromJson(json.decode(str));
String transactionsToJson(Transactions data) => json.encode(data.toJson());
class Transactions {
  Transactions({
      String? id, 
      String? user, 
      num? amount, 
      String? type, 
      Booking? booking, 
      String? createdAt, 
      String? updatedAt, 
      num? v,}){
    _id = id;
    _user = user;
    _amount = amount;
    _type = type;
    _booking = booking;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Transactions.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'];
    _amount = json['amount'];
    _type = json['type'];
    _booking = json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _user;
  num? _amount;
  String? _type;
  Booking? _booking;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Transactions copyWith({  String? id,
  String? user,
  num? amount,
  String? type,
  Booking? booking,
  String? createdAt,
  String? updatedAt,
  num? v,
}) => Transactions(  id: id ?? _id,
  user: user ?? _user,
  amount: amount ?? _amount,
  type: type ?? _type,
  booking: booking ?? _booking,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  v: v ?? _v,
);
  String? get id => _id;
  String? get user => _user;
  num? get amount => _amount;
  String? get type => _type;
  Booking? get booking => _booking;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['amount'] = _amount;
    map['type'] = _type;
    if (_booking != null) {
      map['booking'] = _booking?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
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
      String? labs, 
      List<String>? test, 
      dynamic specialist, 
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
    _labs = json['labs'];
    _test = json['test'] != null ? json['test'].cast<String>() : [];
    _specialist = json['specialist'];
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
  String? _labs;
  List<String>? _test;
  dynamic _specialist;
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
  num? _bookingStatus;
  String? _collectionDate;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Booking copyWith({  String? id,
  String? bookingId,
  Users? users,
  dynamic labUser,
  String? labs,
  List<String>? test,
  dynamic specialist,
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
  String? get labs => _labs;
  List<String>? get test => _test;
  dynamic get specialist => _specialist;
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
    map['labs'] = _labs;
    map['test'] = _test;
    map['specialist'] = _specialist;
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
    map['bookingStatus'] = _bookingStatus;
    map['collectionDate'] = _collectionDate;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

Users usersFromJson(String str) => Users.fromJson(json.decode(str));
String usersToJson(Users data) => json.encode(data.toJson());
class Users {
  Users({
      String? panNumber, 
      String? panImage, 
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
      num? v,}){
    _panNumber = panNumber;
    _panImage = panImage;
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
}

  Users.fromJson(dynamic json) {
    _panNumber = json['panNumber'];
    _panImage = json['panImage'];
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
  }
  String? _panNumber;
  String? _panImage;
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
Users copyWith({  String? panNumber,
  String? panImage,
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
}) => Users(  panNumber: panNumber ?? _panNumber,
  panImage: panImage ?? _panImage,
  id: id ?? _id,
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
);
  String? get panNumber => _panNumber;
  String? get panImage => _panImage;
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['panNumber'] = _panNumber;
    map['panImage'] = _panImage;
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
    return map;
  }

}