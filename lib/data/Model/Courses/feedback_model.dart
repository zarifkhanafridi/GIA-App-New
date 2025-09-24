class FeedBackCoursesModel {
  bool? success;
  String? message;
  List<FeedBackList>? data;

  FeedBackCoursesModel({this.success, this.message, this.data});

  FeedBackCoursesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeedBackList>[];
      json['data'].forEach((v) {
        data!.add(new FeedBackList.fromJson(v));
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

class FeedBackList {
  int? id;
  String? userId;
  String? courseId;
  String? rating;
  String? comments;
  String? createdAt;
  String? updatedAt;

  FeedBackList(
      {this.id,
      this.userId,
      this.courseId,
      this.rating,
      this.comments,
      this.createdAt,
      this.updatedAt});

  FeedBackList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    courseId = json['course_id'];
    rating = json['rating'];
    comments = json['comments'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['course_id'] = this.courseId;
    data['rating'] = this.rating;
    data['comments'] = this.comments;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
