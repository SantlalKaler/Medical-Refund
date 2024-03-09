import 'dart:convert';
TestSearchModel testSearchModelFromJson(String str) => TestSearchModel.fromJson(json.decode(str));
String testSearchModelToJson(TestSearchModel data) => json.encode(data.toJson());
class TestSearchModel {
  TestSearchModel({
      String? status, 
      List<Result>? result,}){
    _status = status;
    _result = result;
}

  TestSearchModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _status;
  List<Result>? _result;
TestSearchModel copyWith({  String? status,
  List<Result>? result,
}) => TestSearchModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? id, 
      String? title, 
      String? shortDesc, 
      String? desc, 
      String? image, 
      String? labName, 
      String? officeAddress, 
      String? labImage, 
      num? price, 
      num? priceBefore, 
      String? labId,}){
    _id = id;
    _title = title;
    _shortDesc = shortDesc;
    _desc = desc;
    _image = image;
    _labName = labName;
    _officeAddress = officeAddress;
    _labImage = labImage;
    _price = price;
    _priceBefore = priceBefore;
    _labId = labId;
}

  Result.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _shortDesc = json['shortDesc'];
    _desc = json['desc'];
    _image = json['image'];
    _labName = json['labName'];
    _officeAddress = json['officeAddress'];
    _labImage = json['labImage'];
    _price = json['price'];
    _priceBefore = json['priceBefore'];
    _labId = json['labId'];
  }
  String? _id;
  String? _title;
  String? _shortDesc;
  String? _desc;
  String? _image;
  String? _labName;
  String? _officeAddress;
  String? _labImage;
  num? _price;
  num? _priceBefore;
  String? _labId;
Result copyWith({  String? id,
  String? title,
  String? shortDesc,
  String? desc,
  String? image,
  String? labName,
  String? officeAddress,
  String? labImage,
  num? price,
  num? priceBefore,
  String? labId,
}) => Result(  id: id ?? _id,
  title: title ?? _title,
  shortDesc: shortDesc ?? _shortDesc,
  desc: desc ?? _desc,
  image: image ?? _image,
  labName: labName ?? _labName,
  officeAddress: officeAddress ?? _officeAddress,
  labImage: labImage ?? _labImage,
  price: price ?? _price,
  priceBefore: priceBefore ?? _priceBefore,
  labId: labId ?? _labId,
);
  String? get id => _id;
  String? get title => _title;
  String? get shortDesc => _shortDesc;
  String? get desc => _desc;
  String? get image => _image;
  String? get labName => _labName;
  String? get officeAddress => _officeAddress;
  String? get labImage => _labImage;
  num? get price => _price;
  num? get priceBefore => _priceBefore;
  String? get labId => _labId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['shortDesc'] = _shortDesc;
    map['desc'] = _desc;
    map['image'] = _image;
    map['labName'] = _labName;
    map['officeAddress'] = _officeAddress;
    map['labImage'] = _labImage;
    map['price'] = _price;
    map['priceBefore'] = _priceBefore;
    map['labId'] = _labId;
    return map;
  }

}