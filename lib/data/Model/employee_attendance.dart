class EmployeeAttendance {
  String? success;
  String? message;
  List<Data>? data;

  EmployeeAttendance({this.success, this.message, this.data});

  EmployeeAttendance.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? uName;
  String? employeeAttendanceID;
  String? employeeID;
  String? day;
  String? month;
  String? year;
  String? timeIn;
  String? timeOut;
  String? defaultTimeIn;
  String? defaultTimeOut;
  String? dutyStatus;
  String? inSnap;
  dynamic outSnap;
  String? createdDate;
  String? date;
  String? desigName;
  String? uImg;
  String? icon;
  String? presentStatus;
  String? lateStatus;

  Data(
      {this.uName,
      this.employeeAttendanceID,
      this.employeeID,
      this.day,
      this.month,
      this.year,
      this.timeIn,
      this.timeOut,
      this.defaultTimeIn,
      this.defaultTimeOut,
      this.dutyStatus,
      this.inSnap,
      this.outSnap,
      this.createdDate,
      this.date,
      this.desigName,
      this.uImg,
      this.icon,
      this.presentStatus,
      this.lateStatus});

  Data.fromJson(Map<String, dynamic> json) {
    uName = json['u_name'];
    employeeAttendanceID = json['Employee_Attendance_ID'];
    employeeID = json['Employee_ID'];
    day = json['Day'];
    month = json['Month'];
    year = json['Year'];
    timeIn = json['Time_In'];
    timeOut = json['Time_Out'];
    defaultTimeIn = json['Default_Time_In'];
    defaultTimeOut = json['Default_Time_Out'];
    dutyStatus = json['Duty_Status'];
    inSnap = json['In_Snap'];
    outSnap = json['Out_Snap'];
    createdDate = json['created_date'];
    date = json['date'];
    desigName = json['desig_name'];
    uImg = json['u_img'];
    icon = json['icon'];
    presentStatus = json['present_status'];
    lateStatus = json['late_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['u_name'] = this.uName;
    data['Employee_Attendance_ID'] = this.employeeAttendanceID;
    data['Employee_ID'] = this.employeeID;
    data['Day'] = this.day;
    data['Month'] = this.month;
    data['Year'] = this.year;
    data['Time_In'] = this.timeIn;
    data['Time_Out'] = this.timeOut;
    data['Default_Time_In'] = this.defaultTimeIn;
    data['Default_Time_Out'] = this.defaultTimeOut;
    data['Duty_Status'] = this.dutyStatus;
    data['In_Snap'] = this.inSnap;
    data['Out_Snap'] = this.outSnap;
    data['created_date'] = this.createdDate;
    data['date'] = this.date;
    data['desig_name'] = this.desigName;
    data['u_img'] = this.uImg;
    data['icon'] = this.icon;
    data['present_status'] = this.presentStatus;
    data['late_status'] = this.lateStatus;
    return data;
  }
}
