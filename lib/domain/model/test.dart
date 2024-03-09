import 'dart:convert';

Test testFromJson(String str) => Test.fromJson(json.decode(str));
String testToJson(Test data) => json.encode(data.toJson());

class Test {
  Test({
    String? id,
    String? title,
    String? id1,
    String? shortDesc,
    String? desc,
    String? thumb,
    String? image,
    num? priceBefore,
    num? price,
    num? adminCommission,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) {
    _id = id;
    _title = title;
    _id1 = id1;
    _shortDesc = shortDesc;
    _desc = desc;
    _thumb = thumb;
    _image = image;
    _priceBefore = priceBefore;
    _price = price;
    _adminCommission = adminCommission;
    _active = active;
    _deleted = deleted;
    _slugHistory = slugHistory;
    _slug = slug;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Test.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _id1 = json['id'];
    _shortDesc = json['shortDesc'];
    _desc = json['desc'];
    _thumb = json['thumb'];
    _image = json['image'];
    _priceBefore = json['priceBefore'];
    _price = json['price'];
    _adminCommission = json['adminCommission'];
    _active = json['active'];
    _deleted = json['deleted'];
    _slugHistory =
        json['slug_history'] != null ? json['slug_history'].cast<String>() : [];
    _slug = json['slug'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _title;
  String? _id1;
  String? _shortDesc;
  String? _desc;
  String? _thumb;
  String? _image;
  num? _priceBefore;
  num? _price;
  num? _active;
  num? _adminCommission;
  num? _deleted;
  List<String>? _slugHistory;
  String? _slug;
  String? _createdAt;
  String? _updatedAt;
  num? _v;
  Test copyWith({
    String? id,
    String? title,
    String? id1,
    String? shortDesc,
    String? desc,
    String? thumb,
    String? image,
    num? priceBefore,
    num? price,
    num? adminCommission,
    num? active,
    num? deleted,
    List<String>? slugHistory,
    String? slug,
    String? createdAt,
    String? updatedAt,
    num? v,
  }) =>
      Test(
        id: id ?? _id,
        title: title ?? _title,
        id1: id1 ?? _id1,
        shortDesc: shortDesc ?? _shortDesc,
        desc: desc ?? _desc,
        thumb: thumb ?? _thumb,
        image: image ?? _image,
        priceBefore: priceBefore ?? _priceBefore,
        price: price ?? _price,
        adminCommission: adminCommission ?? _adminCommission,
        active: active ?? _active,
        deleted: deleted ?? _deleted,
        slugHistory: slugHistory ?? _slugHistory,
        slug: slug ?? _slug,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        v: v ?? _v,
      );
  String? get id => _id;
  String? get title => _title;
  String? get id1 => _id1;
  String? get shortDesc => _shortDesc;
  String? get desc => _desc;
  String? get thumb => _thumb;
  String? get image => _image;
  num? get priceBefore => _priceBefore;
  num? get price => _price;
  num? get adminCommission => _adminCommission;
  num? get active => _active;
  num? get deleted => _deleted;
  List<String>? get slugHistory => _slugHistory;
  String? get slug => _slug;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['id'] = _id1;
    map['shortDesc'] = _shortDesc;
    map['desc'] = _desc;
    map['thumb'] = _thumb;
    map['image'] = _image;
    map['priceBefore'] = _priceBefore;
    map['adminCommission'] = _adminCommission;
    map['price'] = _price;
    map['active'] = _active;
    map['deleted'] = _deleted;
    map['slug_history'] = _slugHistory;
    map['slug'] = _slug;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}
