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
      String? booking, 
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
    _booking = json['booking'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _user;
  num? _amount;
  String? _type;
  String? _booking;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
Transactions copyWith({  String? id,
  String? user,
  num? amount,
  String? type,
  String? booking,
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
  String? get booking => _booking;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user'] = _user;
    map['amount'] = _amount;
    map['type'] = _type;
    map['booking'] = _booking;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}