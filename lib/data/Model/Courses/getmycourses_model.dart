class GetMyCoursesModel {
  bool? success;
  String? message;
  List<GetMyCoursesList>? data;

  GetMyCoursesModel({this.success, this.message, this.data});

  GetMyCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetMyCoursesList>[];
      json['data'].forEach((v) {
        data!.add(new GetMyCoursesList.fromJson(v));
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

class GetMyCoursesList {
  String? courseId;
  String? courseCode;
  String? id;
  String? groupCode;
  String? name;
  String? registrationMethod;
  dynamic description;
  String? isActive;
  String? totalSeat;
  dynamic expireOn;
  String? groupType;
  String? groupName;
  String? masterCategoryId;
  String? groupId;
  String? slug;
  dynamic iconClass;
  dynamic createdAt;
  dynamic updatedAt;
  String? courseTitle;
  String? firstName;
  int? feedbackCount;
  int? feedback;

  GetMyCoursesList(
      {this.courseId,
      this.courseCode,
      this.id,
      this.groupCode,
      this.name,
      this.registrationMethod,
      this.description,
      this.isActive,
      this.totalSeat,
      this.expireOn,
      this.groupType,
      this.groupName,
      this.masterCategoryId,
      this.groupId,
      this.slug,
      this.iconClass,
      this.createdAt,
      this.updatedAt,
      this.courseTitle,
      this.firstName,
      this.feedbackCount,
      this.feedback});

  GetMyCoursesList.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    courseCode = json['course_code'];
    id = json['id'];
    groupCode = json['group_code'];
    name = json['name'];
    registrationMethod = json['registration_method'];
    description = json['description'];
    isActive = json['is_active'];
    totalSeat = json['total_seat'];
    expireOn = json['expire_on'];
    groupType = json['group_type'];
    groupName = json['group_name'];
    masterCategoryId = json['master_category_id'];
    groupId = json['group_id'];
    slug = json['slug'];
    iconClass = json['icon_class'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseTitle = json['course_title'];
    firstName = json['first_name'];
    feedbackCount = json['feedback_count'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['course_code'] = this.courseCode;
    data['id'] = this.id;
    data['group_code'] = this.groupCode;
    data['name'] = this.name;
    data['registration_method'] = this.registrationMethod;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    data['total_seat'] = this.totalSeat;
    data['expire_on'] = this.expireOn;
    data['group_type'] = this.groupType;
    data['group_name'] = this.groupName;
    data['master_category_id'] = this.masterCategoryId;
    data['group_id'] = this.groupId;
    data['slug'] = this.slug;
    data['icon_class'] = this.iconClass;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['course_title'] = this.courseTitle;
    data['first_name'] = this.firstName;
    data['feedback_count'] = this.feedbackCount;
    data['feedback'] = this.feedback;
    return data;
  }
}
