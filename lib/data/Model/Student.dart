// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

StudentModel studentModelFromJson(String str) =>
    StudentModel.fromJson(json.decode(str));

String studentModelToJson(StudentModel data) => json.encode(data.toJson());

class StudentModel {
  StudentModel({
    required this.success,
    required this.message,
    required this.data,
  });

  String success;
  String message;
  Data data;

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
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
  String sId;
  String sDob;
  String uId;
  dynamic sReligion;
  String sNationality;
  String sCurrentHome;
  String sCurrentCiId;
  String sCurrentPovId;
  String sCurrentCounId;
  String sPermanantHome;
  dynamic sPermanantCiId;
  dynamic sPermanantPovId;
  dynamic sPermanantCounId;
  String sStatus;
  dynamic sReason;
  DateTime sCreatedDate;
  dynamic sUpdatedDate;
  String sFatherOccupation;
  dynamic sFatherTel;
  dynamic sFatherMob;
  String sLandline;
  String sSmsEnabled;
  String sBloodGround;
  String sPlaceOfBirth;
  String sDomicile;
  String sMotherToungue;
  String sFatherCnic;
  String sFatherEmail;
  String sFatherSmsEnabled;
  String sFatherOfficeAddress;
  String fatherOfficeContact;
  String sMotherName;
  String sMotherMobile;
  String motheroccupation;
  String mSecondarymobile;
  String mLandline;
  String sMotherSmsEnabled;
  String sCnic;
  String phydis;
  String disabilityinwords;
  String setFatherAsGaurdian;
  String sessionId;
  String nature;
  String houseId;
  String trash;
  String uName;
  String uContact;
  String uFathername;
  dynamic uEmail;
  String uRole;
  String uGender;
  dynamic cId;
  String uUsername;
  String uPassword;
  DateTime uCreatedDate;
  dynamic uUpdatedDate;
  dynamic uCnic;
  String uImg;
  String ipAddress;
  String cardNumber;
  int totalFee;
  String percentage;
  int remaning;
  dynamic totalMarks;
  String marksPercentage;
  dynamic obtainedMarks;
  int totalAttendance;
  int present;
  String attendancePercentage;
  Data({
    required this.sId,
    required this.sDob,
    required this.uId,
    required this.sReligion,
    required this.sNationality,
    required this.sCurrentHome,
    required this.sCurrentCiId,
    required this.sCurrentPovId,
    required this.sCurrentCounId,
    required this.sPermanantHome,
    required this.sPermanantCiId,
    required this.sPermanantPovId,
    required this.sPermanantCounId,
    required this.sStatus,
    required this.sReason,
    required this.sCreatedDate,
    required this.sUpdatedDate,
    required this.sFatherOccupation,
    required this.sFatherTel,
    required this.sFatherMob,
    required this.sLandline,
    required this.sSmsEnabled,
    required this.sBloodGround,
    required this.sPlaceOfBirth,
    required this.sDomicile,
    required this.sMotherToungue,
    required this.sFatherCnic,
    required this.sFatherEmail,
    required this.sFatherSmsEnabled,
    required this.sFatherOfficeAddress,
    required this.fatherOfficeContact,
    required this.sMotherName,
    required this.sMotherMobile,
    required this.motheroccupation,
    required this.mSecondarymobile,
    required this.mLandline,
    required this.sMotherSmsEnabled,
    required this.sCnic,
    required this.phydis,
    required this.disabilityinwords,
    required this.setFatherAsGaurdian,
    required this.sessionId,
    required this.nature,
    required this.houseId,
    required this.trash,
    required this.uName,
    required this.uContact,
    required this.uFathername,
    required this.uEmail,
    required this.uRole,
    required this.uGender,
    required this.cId,
    required this.uUsername,
    required this.uPassword,
    required this.uCreatedDate,
    required this.uUpdatedDate,
    required this.uCnic,
    required this.uImg,
    required this.ipAddress,
    required this.cardNumber,
    required this.totalFee,
    required this.percentage,
    required this.remaning,
    required this.totalMarks,
    required this.marksPercentage,
    required this.obtainedMarks,
    required this.totalAttendance,
    required this.present,
    required this.attendancePercentage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sId: json["s_id"],
        sDob: json["s_dob"],
        uId: json["u_id"],
        sReligion: json["s_religion"],
        sNationality: json["s_nationality"],
        sCurrentHome: json["s_current_home"],
        sCurrentCiId: json["s_current_ci_id"],
        sCurrentPovId: json["s_current_pov_id"],
        sCurrentCounId: json["s_current_coun_id"],
        sPermanantHome: json["s_permanant_home"],
        sPermanantCiId: json["s_permanant_ci_id"],
        sPermanantPovId: json["s_permanant_pov_id"],
        sPermanantCounId: json["s_permanant_coun_id"],
        sStatus: json["s_status"],
        sReason: json["s_reason"],
        sCreatedDate: DateTime.parse(json["s_created_date"]),
        sUpdatedDate: json["s_updated_date"],
        sFatherOccupation: json["s_father_occupation"],
        sFatherTel: json["s_father_tel"],
        sFatherMob: json["s_father_mob"],
        sLandline: json["s_landline"],
        sSmsEnabled: json["s_sms_enabled"],
        sBloodGround: json["s_blood_ground"],
        sPlaceOfBirth: json["s_place_of_birth"],
        sDomicile: json["s_domicile"],
        sMotherToungue: json["s_mother_toungue"],
        sFatherCnic: json["s_father_cnic"],
        sFatherEmail: json["s_father_email"],
        sFatherSmsEnabled: json["s_father_sms_enabled"],
        sFatherOfficeAddress: json["s_father_office_address"],
        fatherOfficeContact: json["father_office_contact"],
        sMotherName: json["s_mother_name"],
        sMotherMobile: json["s_mother_mobile"],
        motheroccupation: json["motheroccupation"],
        mSecondarymobile: json["m_secondarymobile"],
        mLandline: json["m_landline"],
        sMotherSmsEnabled: json["s_mother_sms_enabled"],
        sCnic: json["s_cnic"],
        phydis: json["phydis"],
        disabilityinwords: json["disabilityinwords"],
        setFatherAsGaurdian: json["set_father_as_gaurdian"],
        sessionId: json["session_id"],
        nature: json["nature"],
        houseId: json["house_id"],
        trash: json["trash"],
        uName: json["u_name"],
        uContact: json["u_contact"],
        uFathername: json["u_fathername"],
        uEmail: json["u_email"],
        uRole: json["u_role"],
        uGender: json["u_gender"],
        cId: json["c_id"],
        uUsername: json["u_username"],
        uPassword: json["u_password"],
        uCreatedDate: DateTime.parse(json["u_created_date"]),
        uUpdatedDate: json["u_updated_date"],
        uCnic: json["u_cnic"],
        uImg: json["u_img"],
        ipAddress: json["ip_address"],
        cardNumber: json["Card_Number"],
        totalFee: json["total_fee"],
        percentage: json["percentage"],
        remaning: json["remaning"],
        totalMarks: json["total_marks"],
        marksPercentage: json["marks_percentage"],
        obtainedMarks: json["obtained_marks"],
        totalAttendance: json["total_attendance"],
        present: json["present"],
        attendancePercentage: json["attendance_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "s_id": sId,
        "s_dob": sDob,
        "u_id": uId,
        "s_religion": sReligion,
        "s_nationality": sNationality,
        "s_current_home": sCurrentHome,
        "s_current_ci_id": sCurrentCiId,
        "s_current_pov_id": sCurrentPovId,
        "s_current_coun_id": sCurrentCounId,
        "s_permanant_home": sPermanantHome,
        "s_permanant_ci_id": sPermanantCiId,
        "s_permanant_pov_id": sPermanantPovId,
        "s_permanant_coun_id": sPermanantCounId,
        "s_status": sStatus,
        "s_reason": sReason,
        "s_created_date": sCreatedDate.toIso8601String(),
        "s_updated_date": sUpdatedDate,
        "s_father_occupation": sFatherOccupation,
        "s_father_tel": sFatherTel,
        "s_father_mob": sFatherMob,
        "s_landline": sLandline,
        "s_sms_enabled": sSmsEnabled,
        "s_blood_ground": sBloodGround,
        "s_place_of_birth": sPlaceOfBirth,
        "s_domicile": sDomicile,
        "s_mother_toungue": sMotherToungue,
        "s_father_cnic": sFatherCnic,
        "s_father_email": sFatherEmail,
        "s_father_sms_enabled": sFatherSmsEnabled,
        "s_father_office_address": sFatherOfficeAddress,
        "father_office_contact": fatherOfficeContact,
        "s_mother_name": sMotherName,
        "s_mother_mobile": sMotherMobile,
        "motheroccupation": motheroccupation,
        "m_secondarymobile": mSecondarymobile,
        "m_landline": mLandline,
        "s_mother_sms_enabled": sMotherSmsEnabled,
        "s_cnic": sCnic,
        "phydis": phydis,
        "disabilityinwords": disabilityinwords,
        "set_father_as_gaurdian": setFatherAsGaurdian,
        "session_id": sessionId,
        "nature": nature,
        "house_id": houseId,
        "trash": trash,
        "u_name": uName,
        "u_contact": uContact,
        "u_fathername": uFathername,
        "u_email": uEmail,
        "u_role": uRole,
        "u_gender": uGender,
        "c_id": cId,
        "u_username": uUsername,
        "u_password": uPassword,
        "u_created_date": uCreatedDate.toIso8601String(),
        "u_updated_date": uUpdatedDate,
        "u_cnic": uCnic,
        "u_img": uImg,
        "ip_address": ipAddress,
        "Card_Number": cardNumber,
        "total_fee": totalFee,
        "percentage": percentage,
        "remaning": remaning,
        "total_marks": totalMarks,
        "marks_percentage": marksPercentage,
        "obtained_marks": obtainedMarks,
        "total_attendance": totalAttendance,
        "present": present,
        "attendance_percentage": attendancePercentage,
      };
}
