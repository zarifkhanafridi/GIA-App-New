class MyResultsCoursesModel {
  bool? success;
  String? message;
  List<MyResultCoursesList>? data;

  MyResultsCoursesModel({this.success, this.message, this.data});

  MyResultsCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyResultCoursesList>[];
      json['data'].forEach((v) {
        data!.add(new MyResultCoursesList.fromJson(v));
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

class MyResultCoursesList {
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  dynamic description;
  String? isActive;
  String? totalSeat;
  dynamic expireOn;
  String? groupType;
  String? catName;

  MyResultCoursesList(
      {this.id,
      this.groupCode,
      this.name,
      this.registrationMethod,
      this.description,
      this.isActive,
      this.totalSeat,
      this.expireOn,
      this.groupType,
      this.catName});

  MyResultCoursesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupCode = json['group_code'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    groupType = json['group_type'];
    catName = json['cat_name'];
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
    data['cat_name'] = this.catName;
    return data;
  }
}
