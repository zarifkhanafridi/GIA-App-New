// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final singleTopic = singleTopicFromJson(jsonString);

import 'dart:convert';

SingleTopic singleTopicFromJson(String str) =>
    SingleTopic.fromJson(json.decode(str));

String singleTopicToJson(SingleTopic data) => json.encode(data.toJson());

class SingleTopic {
  String success;
  String message;
  Data data;
  SingleTopic({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SingleTopic.fromJson(Map<String, dynamic> json) => SingleTopic(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String subCouDetId;
  String subId;
  String campusClassId;
  String chapter;
  String subCouDetTitle;
  String subCouDetDescription;
  String subCouDetPdf;
  String subCouDetVideolink;
  DateTime subCouDetDateCreated;
  DateTime subCouDetDateUpdated;
  String syncTill;
  String trash;
  String teacherName;
  List<String> videos;
  Data({
    required this.subCouDetId,
    required this.subId,
    required this.campusClassId,
    required this.chapter,
    required this.subCouDetTitle,
    required this.subCouDetDescription,
    required this.subCouDetPdf,
    required this.subCouDetVideolink,
    required this.subCouDetDateCreated,
    required this.subCouDetDateUpdated,
    required this.syncTill,
    required this.trash,
    required this.teacherName,
    required this.videos,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCouDetId: json["sub_cou_det_id"],
        subId: json["sub_id"],
        campusClassId: json["campus_class_id"],
        chapter: json["chapter"],
        subCouDetTitle: json["sub_cou_det_title"],
        subCouDetDescription: json["sub_cou_det_description"],
        subCouDetPdf: json["sub_cou_det_pdf"],
        subCouDetVideolink: json["sub_cou_det_videolink"],
        subCouDetDateCreated: DateTime.parse(json["sub_cou_det_date_created"]),
        subCouDetDateUpdated: DateTime.parse(json["sub_cou_det_date_updated"]),
        syncTill: json["sync_till"],
        trash: json["trash"],
        teacherName: json["teacher_name"],
        videos: List<String>.from(json["videos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "sub_cou_det_id": subCouDetId,
        "sub_id": subId,
        "campus_class_id": campusClassId,
        "chapter": chapter,
        "sub_cou_det_title": subCouDetTitle,
        "sub_cou_det_description": subCouDetDescription,
        "sub_cou_det_pdf": subCouDetPdf,
        "sub_cou_det_videolink": subCouDetVideolink,
        "sub_cou_det_date_created": subCouDetDateCreated.toIso8601String(),
        "sub_cou_det_date_updated": subCouDetDateUpdated.toIso8601String(),
        "sync_till": syncTill,
        "trash": trash,
        "teacher_name": teacherName,
        "videos": List<dynamic>.from(videos.map((x) => x)),
      };
}
