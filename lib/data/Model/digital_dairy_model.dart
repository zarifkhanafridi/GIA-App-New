class DigitalDiary {
  String? success;
  String? message;
  List<DigitalDiaryList>? dataObject;

  DigitalDiary({this.success, this.message, this.dataObject});

  DigitalDiary.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      dataObject = <DigitalDiaryList>[];
      json['data'].forEach((v) {
        dataObject!.add(new DigitalDiaryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.dataObject != null) {
      data['data'] = this.dataObject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DigitalDiaryList {
  String? dId;
  String? title;
  String? image;
  String? description;
  String? gId;
  String? dDate;
  String? createdDate;
  String? updatedDate;

  DigitalDiaryList(
      {this.dId,
      this.title,
      this.image,
      this.description,
      this.gId,
      this.dDate,
      this.createdDate,
      this.updatedDate});

  DigitalDiaryList.fromJson(Map<String, dynamic> json) {
    dId = json['d_id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    gId = json['g_id'];
    dDate = json['d_date'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['d_id'] = this.dId;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['g_id'] = this.gId;
    data['d_date'] = this.dDate;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    return data;
  }
}
