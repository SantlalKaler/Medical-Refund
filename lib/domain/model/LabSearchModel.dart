import 'dart:convert';

import 'package:lab_test_app/domain/model/Lab.dart';

LabSearchModel labSearchModelFromJson(String str) =>
    LabSearchModel.fromJson(json.decode(str));

String labSearchModelToJson(LabSearchModel data) => json.encode(data.toJson());

class LabSearchModel {
  LabSearchModel({
    String? status,
    List<Lab>? result,
  }) {
    _status = status;
    _result = result;
  }

  LabSearchModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Lab.fromJson(v));
      });
    }
  }

  String? _status;
  List<Lab>? _result;

  LabSearchModel copyWith({
    String? status,
    List<Lab>? result,
  }) =>
      LabSearchModel(
        status: status ?? _status,
        result: result ?? _result,
      );

  String? get status => _status;

  List<Lab>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
