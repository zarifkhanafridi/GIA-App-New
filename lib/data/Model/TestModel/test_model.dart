class TestModel {
  bool? success;
  String? message;
  List<GetAllTestList>? data;

  TestModel({this.success, this.message, this.data});

  TestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetAllTestList>[];
      json['data'].forEach((v) {
        data!.add(new GetAllTestList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllTestList {
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  dynamic description;
  String? isActive;
  String? totalSeat;
  dynamic expireOn;
  String? groupType;
  String? paymentType;
  dynamic image;
  String? catName;
  dynamic iconClass;
  String? slug;
  String? mscatId;

  GetAllTestList(
      {this.id,
      this.groupCode,
      this.name,
      this.registrationMethod,
      this.description,
      this.isActive,
      this.totalSeat,
      this.expireOn,
      this.groupType,
      this.paymentType,
      this.image,
      this.catName,
      this.iconClass,
      this.slug,
      this.mscatId});

  GetAllTestList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    groupType = json['group_type'];
    paymentType = json['group_payment_type'];
    image = json['image'];
    catName = json['cat_name'];
    iconClass = json['icon_class'];
    slug = json['slug'];
    mscatId = json['mscat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_code'] = this.groupCode;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    data['group_type'] = this.groupType;
    data['group_payment_type'] = this.paymentType;
    data['image'] = this.image;
    data['cat_name'] = this.catName;
    data['icon_class'] = this.iconClass;
    data['slug'] = this.slug;
    data['mscat_id'] = this.mscatId;
    return data;
  }
}
