import 'dart:convert';
SettingModel settingModelFromJson(String str) => SettingModel.fromJson(json.decode(str));
String settingModelToJson(SettingModel data) => json.encode(data.toJson());
class SettingModel {
  SettingModel({
      String? status, 
      Result? result,}){
    _status = status;
    _result = result;
}

  SettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _status;
  Result? _result;
SettingModel copyWith({  String? status,
  Result? result,
}) => SettingModel(  status: status ?? _status,
  result: result ?? _result,
);
  String? get status => _status;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      AppSetting? appSetting, 
      Contact? contact, 
      String? privacyPolicy, 
      String? termsAndCondition,}){
    _appSetting = appSetting;
    _contact = contact;
    _privacyPolicy = privacyPolicy;
    _termsAndCondition = termsAndCondition;
}

  Result.fromJson(dynamic json) {
    _appSetting = json['appSetting'] != null ? AppSetting.fromJson(json['appSetting']) : null;
    _contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    _privacyPolicy = json['privacy_policy'];
    _termsAndCondition = json['terms_and_condition'];
  }
  AppSetting? _appSetting;
  Contact? _contact;
  String? _privacyPolicy;
  String? _termsAndCondition;
Result copyWith({  AppSetting? appSetting,
  Contact? contact,
  String? privacyPolicy,
  String? termsAndCondition,
}) => Result(  appSetting: appSetting ?? _appSetting,
  contact: contact ?? _contact,
  privacyPolicy: privacyPolicy ?? _privacyPolicy,
  termsAndCondition: termsAndCondition ?? _termsAndCondition,
);
  AppSetting? get appSetting => _appSetting;
  Contact? get contact => _contact;
  String? get privacyPolicy => _privacyPolicy;
  String? get termsAndCondition => _termsAndCondition;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_appSetting != null) {
      map['appSetting'] = _appSetting?.toJson();
    }
    if (_contact != null) {
      map['contact'] = _contact?.toJson();
    }
    map['privacy_policy'] = _privacyPolicy;
    map['terms_and_condition'] = _termsAndCondition;
    return map;
  }

}

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));
String contactToJson(Contact data) => json.encode(data.toJson());
class Contact {
  Contact({
      String? email, 
      String? email2, 
      String? phoneNumber, 
      String? phoneNumber2, 
      String? address, 
      String? address2, 
      String? fb, 
      String? twitter, 
      String? instagram, 
      String? linkdin, 
      String? mapCode, 
      String? skype,}){
    _email = email;
    _email2 = email2;
    _phoneNumber = phoneNumber;
    _phoneNumber2 = phoneNumber2;
    _address = address;
    _address2 = address2;
    _fb = fb;
    _twitter = twitter;
    _instagram = instagram;
    _linkdin = linkdin;
    _mapCode = mapCode;
    _skype = skype;
}

  Contact.fromJson(dynamic json) {
    _email = json['email'];
    _email2 = json['email2'];
    _phoneNumber = json['phone_number'];
    _phoneNumber2 = json['phone_number2'];
    _address = json['address'];
    _address2 = json['address2'];
    _fb = json['fb'];
    _twitter = json['twitter'];
    _instagram = json['instagram'];
    _linkdin = json['linkdin'];
    _mapCode = json['map_code'];
    _skype = json['skype'];
  }
  String? _email;
  String? _email2;
  String? _phoneNumber;
  String? _phoneNumber2;
  String? _address;
  String? _address2;
  String? _fb;
  String? _twitter;
  String? _instagram;
  String? _linkdin;
  String? _mapCode;
  String? _skype;
Contact copyWith({  String? email,
  String? email2,
  String? phoneNumber,
  String? phoneNumber2,
  String? address,
  String? address2,
  String? fb,
  String? twitter,
  String? instagram,
  String? linkdin,
  String? mapCode,
  String? skype,
}) => Contact(  email: email ?? _email,
  email2: email2 ?? _email2,
  phoneNumber: phoneNumber ?? _phoneNumber,
  phoneNumber2: phoneNumber2 ?? _phoneNumber2,
  address: address ?? _address,
  address2: address2 ?? _address2,
  fb: fb ?? _fb,
  twitter: twitter ?? _twitter,
  instagram: instagram ?? _instagram,
  linkdin: linkdin ?? _linkdin,
  mapCode: mapCode ?? _mapCode,
  skype: skype ?? _skype,
);
  String? get email => _email;
  String? get email2 => _email2;
  String? get phoneNumber => _phoneNumber;
  String? get phoneNumber2 => _phoneNumber2;
  String? get address => _address;
  String? get address2 => _address2;
  String? get fb => _fb;
  String? get twitter => _twitter;
  String? get instagram => _instagram;
  String? get linkdin => _linkdin;
  String? get mapCode => _mapCode;
  String? get skype => _skype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['email2'] = _email2;
    map['phone_number'] = _phoneNumber;
    map['phone_number2'] = _phoneNumber2;
    map['address'] = _address;
    map['address2'] = _address2;
    map['fb'] = _fb;
    map['twitter'] = _twitter;
    map['instagram'] = _instagram;
    map['linkdin'] = _linkdin;
    map['map_code'] = _mapCode;
    map['skype'] = _skype;
    return map;
  }

}

AppSetting appSettingFromJson(String str) => AppSetting.fromJson(json.decode(str));
String appSettingToJson(AppSetting data) => json.encode(data.toJson());
class AppSetting {
  AppSetting({
      String? id, 
      bool? labs, 
      bool? specialist, 
      bool? test, 
      String? updatedAt,}){
    _id = id;
    _labs = labs;
    _specialist = specialist;
    _test = test;
    _updatedAt = updatedAt;
}

  AppSetting.fromJson(dynamic json) {
    _id = json['_id'];
    _labs = json['labs'];
    _specialist = json['specialist'];
    _test = json['test'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  bool? _labs;
  bool? _specialist;
  bool? _test;
  String? _updatedAt;
AppSetting copyWith({  String? id,
  bool? labs,
  bool? specialist,
  bool? test,
  String? updatedAt,
}) => AppSetting(  id: id ?? _id,
  labs: labs ?? _labs,
  specialist: specialist ?? _specialist,
  test: test ?? _test,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  bool? get labs => _labs;
  bool? get specialist => _specialist;
  bool? get test => _test;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['labs'] = _labs;
    map['specialist'] = _specialist;
    map['test'] = _test;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}