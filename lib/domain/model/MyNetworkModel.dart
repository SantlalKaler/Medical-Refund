import 'dart:convert';

import 'auth/user.dart';
MyNetworkModel myNetworkModelFromJson(String str) => MyNetworkModel.fromJson(json.decode(str));
String myNetworkModelToJson(MyNetworkModel data) => json.encode(data.toJson());
class MyNetworkModel {
  MyNetworkModel({
      String? status, 
      String? message, 
      List<Result>? result, 
      String? imgBaseURL,}){
    _status = status;
    _message = message;
    _result = result;
    _imgBaseURL = imgBaseURL;
}

  MyNetworkModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
    _imgBaseURL = json['imgBaseURL'];
  }
  String? _status;
  String? _message;
  List<Result>? _result;
  String? _imgBaseURL;
MyNetworkModel copyWith({  String? status,
  String? message,
  List<Result>? result,
  String? imgBaseURL,
}) => MyNetworkModel(  status: status ?? _status,
  message: message ?? _message,
  result: result ?? _result,
  imgBaseURL: imgBaseURL ?? _imgBaseURL,
);
  String? get status => _status;
  String? get message => _message;
  List<Result>? get result => _result;
  String? get imgBaseURL => _imgBaseURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    map['imgBaseURL'] = _imgBaseURL;
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      User? user, 
      List<Network>? network,}){
    _user = user;
    _network = network;
}

  Result.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['network'] != null) {
      _network = [];
      json['network'].forEach((v) {
        _network?.add(Network.fromJson(v));
      });
    }
  }
  User? _user;
  List<Network>? _network;
Result copyWith({  User? user,
  List<Network>? network,
}) => Result(  user: user ?? _user,
  network: network ?? _network,
);
  User? get user => _user;
  List<Network>? get network => _network;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_network != null) {
      map['network'] = _network?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Network networkFromJson(String str) => Network.fromJson(json.decode(str));
String networkToJson(Network data) => json.encode(data.toJson());
class Network {
  Network({
      User? user, 
      List<Network>? network,}){
    _user = user;
    _network = network;
}

  Network.fromJson(dynamic json) {
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['network'] != null) {
      _network = [];
      json['network'].forEach((v) {
        _network?.add(Network.fromJson(v));
      });
    }
  }
  User? _user;
  List<Network>? _network;
Network copyWith({  User? user,
  List<Network>? network,
}) => Network(  user: user ?? _user,
  network: network ?? _network,
);
  User? get user => _user;
  List<dynamic>? get network => _network;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_network != null) {
      map['network'] = _network?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
