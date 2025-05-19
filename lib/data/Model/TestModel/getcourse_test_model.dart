class GetCourseTestsModel {
  bool? success;
  String? message;
  List<GetCoursesTextList>? data;

  GetCourseTestsModel({this.success, this.message, this.data});

  GetCourseTestsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetCoursesTextList>[];
      json['data'].forEach((v) {
        data!.add(new GetCoursesTextList.fromJson(v));
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

class GetCoursesTextList {
  String? id;
  String? categoryId;
  String? testCode;
  String? testTitle;
  String? totalTime;
  String? testStart;
  String? userId;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? testType;
  String? testGroupId;
  GetCoursesTextList(
      {this.id,
      this.categoryId,
      this.testCode,
      this.testTitle,
      this.totalTime,
      this.testStart,
      this.userId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.testType,
      this.testGroupId});

  GetCoursesTextList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    testCode = json['test_code'];
    testTitle = json['test_title'];
    totalTime = json['total_time'];
    testStart = json['test_start'];
    userId = json['user_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    testType = json['test_type'];
    testGroupId = json['group_test_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['test_code'] = this.testCode;
    data['test_title'] = this.testTitle;
    data['total_time'] = this.totalTime;
    data['test_start'] = this.testStart;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['test_type'] = this.testType;
    data['group_test_id'] = this.testGroupId;
    return data;
  }
}
