// To parse this JSON data, do
//
//     final onlineClass = onlineClassFromJson(jsonString);

import 'dart:convert';

OnlineClass onlineClassFromJson(String str) =>
    OnlineClass.fromJson(json.decode(str));

String onlineClassToJson(OnlineClass data) => json.encode(data.toJson());

class OnlineClass {
  OnlineClass({
    required this.success,
    required this.message,
    required this.data,
  });

  String success;
  String message;
  OnlineClassDataList data;

  factory OnlineClass.fromJson(Map<String, dynamic> json) => OnlineClass(
        success: json["success"],
        message: json["message"],
        data: OnlineClassDataList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class OnlineClassDataList {
  OnlineClassDataList({
    required this.gId,
    required this.gName,
    required this.gType,
    required this.gSessionType,
    required this.orderby,
    required this.subjects,
  });

  String gId;
  String gName;
  String gType;
  String gSessionType;
  String orderby;
  List<Subject> subjects;

  factory OnlineClassDataList.fromJson(Map<String, dynamic> json) =>
      OnlineClassDataList(
        gId: json["g_id"],
        gName: json["g_name"],
        gType: json["g_type"],
        gSessionType: json["g_session_type"],
        orderby: json["orderby"],
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "g_id": gId,
        "g_name": gName,
        "g_type": gType,
        "g_session_type": gSessionType,
        "orderby": orderby,
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class Subject {
  Subject({
    required this.clTSubId,
    required this.uId,
    required this.ccSectionId,
    required this.subId,
    required this.clTSubCreatedDate,
    required this.clTSubDate,
    required this.haveExam,
    required this.hasMontlytest,
    required this.subName,
    required this.ccsId,
    required this.campusClassid,
    required this.secId,
    required this.ccsCreatedDate,
    required this.ccsUpdatedDate,
    required this.sessionId,
    required this.orderBy,
  });

  String clTSubId;
  String uId;
  String ccSectionId;
  String subId;
  DateTime clTSubCreatedDate;
  String clTSubDate;
  String haveExam;
  String hasMontlytest;
  String subName;
  String ccsId;
  String campusClassid;
  String secId;
  DateTime ccsCreatedDate;
  String ccsUpdatedDate;
  String sessionId;
  String orderBy;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        clTSubId: json["cl_t_sub_id"],
        uId: json["u_id"],
        ccSectionId: json["cc_section_id"],
        subId: json["sub_id"],
        clTSubCreatedDate: DateTime.parse(json["cl_t_sub_created_date"]),
        clTSubDate: json["cl_t_sub_date"],
        haveExam: json["have_exam"],
        hasMontlytest: json["has_montlytest"],
        subName: json["sub_name"],
        ccsId: json["ccs_id"],
        campusClassid: json["campus_classid"],
        secId: json["sec_id"],
        ccsCreatedDate: DateTime.parse(json["ccs_created_date"]),
        ccsUpdatedDate: json["ccs_updated_date"],
        sessionId: json["session_id"],
        orderBy: json["order_by"],
      );

  Map<String, dynamic> toJson() => {
        "cl_t_sub_id": clTSubId,
        "u_id": uId,
        "cc_section_id": ccSectionId,
        "sub_id": subId,
        "cl_t_sub_created_date": clTSubCreatedDate.toIso8601String(),
        "cl_t_sub_date": clTSubDate,
        "have_exam": haveExam,
        "has_montlytest": hasMontlytest,
        "sub_name": subName,
        "ccs_id": ccsId,
        "campus_classid": campusClassid,
        "sec_id": secId,
        "ccs_created_date": ccsCreatedDate.toIso8601String(),
        "ccs_updated_date": ccsUpdatedDate,
        "session_id": sessionId,
        "order_by": orderBy,
      };
}
