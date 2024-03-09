import 'package:lab_test_app/domain/model/specialist.dart';

import 'Lab.dart';
import 'auth/user.dart';

class MessageReceivedModel {
  String? sId;
  User? users;
  Specialist? specialist;
  Lab? lab;
  String? sender;
  String? message;
  String? createdAt;
  String? updatedAt;
  int? iV;

  MessageReceivedModel(
      {this.sId,
        this.users,
        this.specialist,
        this.lab,
        this.sender,
        this.message,
        this.createdAt,
        this.updatedAt,
        this.iV});

  MessageReceivedModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = json['users'] != null ?  User.fromJson(json['users']) : null;
    specialist = json['specialist'] != null ?  Specialist.fromJson(json['specialist']) : null;
    lab = json['lab'] != null ? Lab.fromJson(json['lab']) : null;
    sender = json['sender'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    if (specialist != null) {
      data['specialist'] = specialist!.toJson();
    }
    if (lab != null) {
      data['lab'] = lab!.toJson();
    }
    data['sender'] = sender;
    data['message'] = message;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}