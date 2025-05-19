class coursesOfferModel {
  bool? success;
  String? message;
  CoursesOfferList? data;

  coursesOfferModel({this.success, this.message, this.data});

  coursesOfferModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new CoursesOfferList.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CoursesOfferList {
  List<Category>? category;
  List<Slides>? slides;

  CoursesOfferList({this.category, this.slides});

  CoursesOfferList.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(new Slides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.slides != null) {
      data['slides'] = this.slides!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  String? description;
  String? isActive;
  String? totalSeat;
  String? expireOn;
  String? groupType;
  String? image;
  String? catName;
  String? iconClass;
  String? slug;
  String? mscatId;

  Category(
      {this.id,
      this.groupCode,
      this.name,
      this.registrationMethod,
      this.description,
      this.isActive,
      this.totalSeat,
      this.expireOn,
      this.groupType,
      this.image,
      this.catName,
      this.iconClass,
      this.slug,
      this.mscatId});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    groupType = json['group_type'];
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
    data['image'] = this.image;
    data['cat_name'] = this.catName;
    data['icon_class'] = this.iconClass;
    data['slug'] = this.slug;
    data['mscat_id'] = this.mscatId;
    return data;
  }
}

class Slides {
  int? id;
  String? title;
  String? createdAt;
  String? filePath;
  String? position;

  Slides({this.id, this.title, this.createdAt, this.filePath, this.position});

  Slides.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    filePath = json['file_path'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['file_path'] = this.filePath;
    data['position'] = this.position;
    return data;
  }
}
