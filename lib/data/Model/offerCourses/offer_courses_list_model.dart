class OfferCoursesListModel {
  bool? success;
  String? message;
  List<CourseList>? data;

  OfferCoursesListModel({this.success, this.message, this.data});

  OfferCoursesListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CourseList>[];
      json['data'].forEach((v) {
        data!.add(new CourseList.fromJson(v));
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

class CourseList {
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
  int? total_price;
  List<ResultDetails>? courses;
  String? groupPaymentType;

  CourseList({
    this.id,
    this.groupCode,
    this.name,
    this.registrationMethod,
    this.description,
    this.isActive,
    this.totalSeat,
    this.expireOn,
    this.groupType,
    this.catName,
    this.total_price,
    this.courses,
    this.groupPaymentType,
  });

  CourseList.fromJson(Map<String, dynamic> json) {
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
    total_price = json['total_price'];
    groupPaymentType = json['group_payment_type'];
    if (json['courses'] != null) {
      courses = <ResultDetails>[];
      json['courses'].forEach((v) {
        courses!.add(new ResultDetails.fromJson(v));
      });
    }
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
    data['total_price'] = this.total_price;
    data['group_payment_type'] = this.groupPaymentType;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultDetails {
  String? id;
  String? instructorId;
  String? categoryId;
  String? masterCourseId;
  dynamic instructionLevelId;
  String? courseCode;
  String? courseTitle;
  dynamic courseOverviewUrl;
  String? courseSlug;
  dynamic keywords;
  dynamic overview;
  dynamic courseImage;
  dynamic thumbImage;
  dynamic courseVideo;
  dynamic duration;
  String? price;
  String? classTime;
  dynamic strikeOutPrice;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? firstName;

  ResultDetails(
      {this.id,
      this.instructorId,
      this.categoryId,
      this.masterCourseId,
      this.instructionLevelId,
      this.courseCode,
      this.courseTitle,
      this.courseOverviewUrl,
      this.courseSlug,
      this.keywords,
      this.overview,
      this.courseImage,
      this.thumbImage,
      this.courseVideo,
      this.duration,
      this.price,
      this.classTime,
      this.strikeOutPrice,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.firstName});

  ResultDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    instructorId = json['instructor_id'] ?? '';
    categoryId = json['category_id'] ?? '';
    masterCourseId = json['master_course_id'] ?? '';
    instructionLevelId = json['instruction_level_id'] ?? '';
    courseCode = json['course_code'] ?? '';
    courseTitle = json['course_title'] ?? '';
    courseOverviewUrl = json['course_overview_url'] ?? '';
    courseSlug = json['course_slug'] ?? '';
    keywords = json['keywords'] ?? '';
    overview = json['overview'] ?? '';
    courseImage = json['course_image'] ?? '';
    thumbImage = json['thumb_image'] ?? '';
    courseVideo = json['course_video'] ?? '';
    duration = json['duration'] ?? '';
    price = json['price'] ?? '';
    classTime = json['class_time'] ?? '';
    strikeOutPrice = json['strike_out_price'] ?? '';
    isActive = json['is_active'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    firstName = json['first_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['instructor_id'] = this.instructorId;
    data['category_id'] = this.categoryId;
    data['master_course_id'] = this.masterCourseId;
    data['instruction_level_id'] = this.instructionLevelId;
    data['course_code'] = this.courseCode;
    data['course_title'] = this.courseTitle;
    data['course_overview_url'] = this.courseOverviewUrl;
    data['course_slug'] = this.courseSlug;
    data['keywords'] = this.keywords;
    data['overview'] = this.overview;
    data['course_image'] = this.courseImage;
    data['thumb_image'] = this.thumbImage;
    data['course_video'] = this.courseVideo;
    data['duration'] = this.duration;
    data['price'] = this.price;
    data['class_time'] = this.classTime;
    data['strike_out_price'] = this.strikeOutPrice;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    return data;
  }
}
