// ignore_for_file: non_constant_identifier_names

class Employee {
  final String? e_id;
  final String? name;
  final String? fathername;
  final String? image;
  final String? designation_id;
  final String? designation;
  final String? department_id;
  final String? department;
  final String? sub_department_id;
  final String? sub_department;
  final String? email;
  final String? address;
  final String? mobile;

  Employee(
      {this.e_id,
      this.name,
      this.fathername,
      this.image,
      this.designation_id,
      this.designation,
      this.department_id,
      this.department,
      this.sub_department_id,
      this.sub_department,
      this.email,
      this.address,
      this.mobile});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      e_id: json['e_id'],
      name: json['u_name'],
      fathername: json['u_fathername'],
      image: json['u_img'],
      designation_id: json['desig_id'].toString(),
      designation: json['desig_name'].toString(),
      department_id: json['dep_id'].toString(),
      department: json['dep_name'].toString(),
      sub_department_id: json['sub_id'].toString(),
      sub_department: json['sub_name'].toString(),
      email: json['u_email'],
      address: json['emp_p_address'],
      mobile: json['u_contact'],
    );
  }
}
