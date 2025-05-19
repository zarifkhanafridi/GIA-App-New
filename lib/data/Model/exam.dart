class ExamModel {
  String? success;
  String? message;
  List<ExamDataList>? data;

  ExamModel({this.success, this.message, this.data});

  ExamModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ExamDataList>[];
      json['data'].forEach((v) {
        data!.add(new ExamDataList.fromJson(v));
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

class ExamDataList {
  String? assesmentTypeId;
  String? assesmentName;
  String? type;
  String? assesmentType;

  ExamDataList(
      {this.assesmentTypeId,
      this.assesmentName,
      this.type,
      this.assesmentType});

  ExamDataList.fromJson(Map<String, dynamic> json) {
    assesmentTypeId = json['assesment_type_id'];
    assesmentName = json['assesment_name'];
    type = json['type'];
    assesmentType = json['assesment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['assesment_type_id'] = this.assesmentTypeId;
    data['assesment_name'] = this.assesmentName;
    data['type'] = this.type;
    data['assesment_type'] = this.assesmentType;
    return data;
  }
}
