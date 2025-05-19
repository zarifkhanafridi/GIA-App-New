class StudentAttendance {
  String? success;
  String? message;
  Data? data;

  StudentAttendance({this.success, this.message, this.data});

  StudentAttendance.fromJson(Map<String, dynamic> json) {
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
  int? total;
  int? present;
  int? absent;
  String? date;

  Data({this.total, this.present, this.absent, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    present = json['present'];
    absent = json['absent'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['present'] = this.present;
    data['absent'] = this.absent;
    data['date'] = this.date;
    return data;
  }
}
