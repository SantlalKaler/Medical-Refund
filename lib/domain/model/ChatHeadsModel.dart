import 'dart:convert';

import 'package:lab_test_app/domain/model/MessageReceivedModel.dart';

ChatHeadModel chatHeadModelJson(String str) =>
    ChatHeadModel.fromJson(json.decode(str));

String chatHeadModelToJson(ChatHeadModel data) => json.encode(data.toJson());

class ChatHeadModel {
  ChatHeadModel({
    String? status,
    String? message,
    List<MessageReceivedModel>? result,
  }) {
    _status = status;
    _result = result;
  }

  ChatHeadModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(MessageReceivedModel.fromJson(v));
      });
    }
  }

  String? _status;
  String? _message;
  List<MessageReceivedModel>? _result;

  ChatHeadModel copyWith({
    String? status,
    String? message,
    List<MessageReceivedModel>? result,
  }) =>
      ChatHeadModel(
        status: status ?? _status,
        result: result ?? _result,
      );

  String? get status => _status;

  String? get message => _message;

  List<MessageReceivedModel>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
