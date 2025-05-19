// To parse this JSON data, do
//
//     final employStudentAttendanceSummary = employStudentAttendanceSummaryFromJson(jsonString);

import 'dart:convert';

EmployStudentAttendanceSummary? employStudentAttendanceSummaryFromJson(
        String str) =>
    EmployStudentAttendanceSummary.fromJson(json.decode(str));

String employStudentAttendanceSummaryToJson(
        EmployStudentAttendanceSummary? data) =>
    json.encode(data!.toJson());

class EmployStudentAttendanceSummary {
  EmployStudentAttendanceSummary({
    required this.success,
    required this.message,
    required this.data,
  });

  String success;
  String message;
  Data data;

  factory EmployStudentAttendanceSummary.fromJson(Map<String, dynamic> json) =>
      EmployStudentAttendanceSummary(
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
  Data({
    required this.employee,
    required this.student,
  });

  Employee employee;
  Student student;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        employee: Employee.fromJson(json["employee"]),
        student: Student.fromJson(json["student"]),
      );

  Map<String, dynamic> toJson() => {
        "employee": employee.toJson(),
        "student": student.toJson(),
      };
}

class Employee {
  Employee({
    required this.presentEmp,
    required this.totalEmp,
    required this.attPercentage,
  });

  int presentEmp;
  int totalEmp;
  double attPercentage;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        presentEmp: json["present_emp"],
        totalEmp: json["total_emp"],
        attPercentage: json["att_percentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "present_emp": presentEmp,
        "total_emp": totalEmp,
        "att_percentage": attPercentage,
      };
}

class Student {
  Student({
    required this.total,
    required this.present,
    required this.absent,
    required this.date,
    required this.attPercentage,
  });

  int total;
  int present;
  int absent;
  String date;
  double attPercentage;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        total: json["total"],
        present: json["present"],
        absent: json["absent"],
        date: json["date"],
        attPercentage: json["att_percentage"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "present": present,
        "absent": absent,
        "date": date,
        "att_percentage": attPercentage,
      };
}
