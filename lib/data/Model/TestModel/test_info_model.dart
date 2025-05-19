class TestInfoModel {
  bool? success;
  String? message;
  TestInfo? data;

  TestInfoModel({this.success, this.message, this.data});

  TestInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? TestInfo.fromJson(json['data']) : null;
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

class TestInfo {
  String? testGroupId;
  String? testType;
  String? groupType;
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
  int? totalQuestion;
  int? fee;

  TestInfo(
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
      this.totalQuestion,
      this.fee,
      this.groupType,
      this.testType,
      this.testGroupId});

  TestInfo.fromJson(Map<String, dynamic> json) {
    testGroupId = json['group_test_id'] ?? '';
    testType = json['test_type'] ?? '';
    id = json['id'] ?? "";
    categoryId = json['category_id'] ?? '';
    testCode = json['test_code'] ?? '';
    testTitle = json['test_title'] ?? '';
    totalTime = json['total_time'] ?? '';
    testStart = json['test_start'] ?? "";
    userId = json['user_id'] ?? "";
    status = json['status'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    totalQuestion = json['total_question'] ?? 0;
    fee = json['fee'] ?? 0;
    groupType = json['group_type'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_type'] = this.testType;
    data['group_test_id'] = this.testGroupId;
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
    data['total_question'] = this.totalQuestion;
    data['fee'] = this.fee;
    data['group_type'] = this.groupType;
    return data;
  }
}
