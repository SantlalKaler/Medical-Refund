

import 'dart:convert';

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
  List? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}