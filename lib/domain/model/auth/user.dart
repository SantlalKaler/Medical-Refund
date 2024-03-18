import 'dart:convert';
User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? id, 
      String? name, 
      String? mobile, 
      String? image, 
      String? deviceToken, 
      String? deviceType, 
      num? active, 
      num? deleted, 
      String? createdAt,
      String? updatedAt, 
      String? refCode,
      String? panNumber,
      num? v,
      String? dobDate, 
      String? panImage,
      String? dobDateUnix,
  String? email}){
    _id = id;
    _name = name;
    _mobile = mobile;
    _image = image;
    _deviceToken = deviceToken;
    _deviceType = deviceType;
    _active = active;
    _deleted = deleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refCode = refCode;
    _panNumber = panNumber;
    _panImage = panImage;
    _v = v;
    _dobDate = dobDate;
    _dobDateUnix = dobDateUnix;
    _email = email;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _mobile = json['mobile'];
    _image = json['image'];
    _deviceToken = json['deviceToken'];
    _deviceType = json['deviceType'];
    _active = json['active'];
    _deleted = json['deleted'];
    _panNumber = json['panNumber'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _refCode = json['refCode'];
    _v = json['__v'];
    _panImage = json['panImage'];
    _dobDate = json['dobDate'];
    _dobDateUnix = json['dobDateUnix'];
    _email = json['email'];
  }
  String? _id;
  String? _name;
  String? _mobile;
  String? _image;
  String? _panNumber;
  String? _deviceToken;
  String? _deviceType;
  num? _active;
  num? _deleted;
  String? _createdAt;
  String? _updatedAt;
  String? _refCode;
  num? _v;
  String? _dobDate;
  String? _panImage;
  String? _dobDateUnix;
  String? _email;
User copyWith({  String? id,
  String? name,
  String? mobile,
  String? image,
  String? panNumber,
  String? deviceToken,
  String? deviceType,
  num? active,
  num? deleted,
  String? createdAt,
  String? updatedAt,
  String? panImage,
  String? refCode,
  num? v,
  String? dobDate,
  String? dobDateUnix,
  String? email,
}) => User(  id: id ?? _id,
  name: name ?? _name,
  mobile: mobile ?? _mobile,
  image: image ?? _image,
  panNumber: panNumber ?? _panNumber,
  deviceToken: deviceToken ?? _deviceToken,
  deviceType: deviceType ?? _deviceType,
  active: active ?? _active,
  deleted: deleted ?? _deleted,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  panImage: panImage ?? _panImage,
  refCode: refCode ?? _refCode,
  v: v ?? _v,
  dobDate: dobDate ?? _dobDate,
  dobDateUnix: dobDateUnix ?? _dobDateUnix,
  email: email ?? _email,
);
  String? get id => _id;
  String? get name => _name;
  String? get mobile => _mobile;
  String? get image => _image;
  String? get panNumber => _panNumber;
  String? get deviceToken => _deviceToken;
  String? get deviceType => _deviceType;
  num? get active => _active;
  num? get deleted => _deleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refCode => _refCode;
  String? get panImage => _panImage;
  num? get v => _v;
  String? get dobDate => _dobDate;
  String? get dobDateUnix => _dobDateUnix;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['mobile'] = _mobile;
    map['image'] = _image;
    map['deviceToken'] = _deviceToken;
    map['panImage'] = _panImage;
    map['panNumber'] = _panNumber;
    map['deviceType'] = _deviceType;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['refCode'] = _refCode;
    map['__v'] = _v;
    map['dobDate'] = _dobDate;
    map['dobDateUnix'] = _dobDateUnix;
    map['email'] = _email;
    return map;
  }

}