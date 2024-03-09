import 'dart:convert';

import 'package:lab_test_app/domain/model/specialist.dart';
SpecialistSearchModel specialistSearchModelFromJson(String str) => SpecialistSearchModel.fromJson(json.decode(str));
String specialistSearchModelToJson(SpecialistSearchModel data) => json.encode(data.toJson());
class SpecialistSearchModel {
  SpecialistSearchModel({
      String? status, 
      List<Specialist>? result,}){
    _status = status;
    _result = result;
}

  SpecialistSearchModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Specialist.fromJson(v));
      });
    }
  }
  String? _status;
  List<Specialist>? _result;
SpecialistSearchModel copyWith({  String? status,
  List<Specialist>? result,
}) => SpecialistSearchModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  List<Specialist>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}