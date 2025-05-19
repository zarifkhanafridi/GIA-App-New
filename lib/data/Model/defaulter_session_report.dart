class DefaulterSessionReportModel {
  String? success;
  String? message;
  Data? data;

  DefaulterSessionReportModel({this.success, this.message, this.data});

  DefaulterSessionReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? totalDefault;
  String? school;
  String? college;

  Data({this.totalDefault, this.school, this.college});

  Data.fromJson(Map<String, dynamic> json) {
    totalDefault = json['total_default'];
    school = json['School'];
    college = json['college'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_default'] = this.totalDefault;
    data['School'] = this.school;
    data['college'] = this.college;
    return data;
  }
}
