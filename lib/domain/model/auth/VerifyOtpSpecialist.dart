import 'dart:convert';

import '../specialist.dart';
VerifyOtpSpecialist verifyOtpSpecialistFromJson(String str) => VerifyOtpSpecialist.fromJson(json.decode(str));
String verifyOtpSpecialistToJson(VerifyOtpSpecialist data) => json.encode(data.toJson());
class VerifyOtpSpecialist {
  VerifyOtpSpecialist({
      String? status, 
      String? message, 
      Specialist? specialist,}){
    _status = status;
    _message = message;
    _specialist = specialist;
}

  VerifyOtpSpecialist.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _specialist = json['result'] != null ? Specialist.fromJson(json['result']) : null;
  }
  String? _status;
  String? _message;
  Specialist? _specialist;
VerifyOtpSpecialist copyWith({  String? status,
  String? message,
  Specialist? specialist,
}) => VerifyOtpSpecialist(  status: status ?? _status,
  message: message ?? _message,
  specialist: specialist ?? _specialist,
);
  String? get status => _status;
  String? get message => _message;
  Specialist? get specialist => _specialist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_specialist != null) {
      map['result'] = _specialist?.toJson();
    }
    return map;
  }

}
