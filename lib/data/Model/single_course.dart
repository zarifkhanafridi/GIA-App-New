class SingleCourse {
  String? success;
  String? message;
  List<CourcesList>? data;

  SingleCourse({this.success, this.message, this.data});

  SingleCourse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CourcesList>[];
      json['data'].forEach((v) {
        data!.add(new CourcesList.fromJson(v));
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

class CourcesList {
  String? subCouDetId;
  String? chapter;
  String? subCouDetTitle;
  String? subCouDetPdf;
  String? subCouDetVideolink;
  String? teacherName;

  CourcesList(
      {this.subCouDetId,
      this.chapter,
      this.subCouDetTitle,
      this.subCouDetPdf,
      this.subCouDetVideolink,
      this.teacherName});

  CourcesList.fromJson(Map<String, dynamic> json) {
    subCouDetId = json['sub_cou_det_id'];
    chapter = json['chapter'];
    subCouDetTitle = json['sub_cou_det_title'];
    subCouDetPdf = json['sub_cou_det_pdf'];
    subCouDetVideolink = json['sub_cou_det_videolink'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_cou_det_id'] = this.subCouDetId;
    data['chapter'] = this.chapter;
    data['sub_cou_det_title'] = this.subCouDetTitle;
    data['sub_cou_det_pdf'] = this.subCouDetPdf;
    data['sub_cou_det_videolink'] = this.subCouDetVideolink;
    data['teacher_name'] = this.teacherName;
    return data;
  }
}
