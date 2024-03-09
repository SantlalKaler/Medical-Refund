import 'dart:convert';

import 'package:lab_test_app/domain/model/auth/user.dart';


VerifyOtp verifyOtpFromJson(String str) => VerifyOtp.fromJson(json.decode(str));
String verifyOtpToJson(VerifyOtp data) => json.encode(data.toJson());
class VerifyOtp {
  VerifyOtp({
      String? status, 
      String? message, 
      User? user,}){
    _status = status;
    _message = message;
    _user = user;
}

  VerifyOtp.fromJson(dynamic json) {
    print(json);
    _status = json['status'];
    _message = json['message'];
    _user = (json['result'] != null) ? User.fromJson(json['result']) : (json['result'].isBlank) ? null : null;
    //_user = (json['result'] != null) ? User.fromJson(json['result']) : (json['result'].isBlank) ? null : null;
   /* if (json['result'] != null) {
      _user = User();
      //User.fromJson(json['result']);
    }*/
  }
  String? _status;
  String? _message;
  User? _user;
VerifyOtp copyWith({  String? status,
  String? message,
  User? user,
}) => VerifyOtp(  status: status ?? _status,
  message: message ?? _message,
  user: user ?? _user,
);
  String? get status => _status;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_user != null) {
      map['result'] = _user?.toJson();
    }
    return map;
  }

}
