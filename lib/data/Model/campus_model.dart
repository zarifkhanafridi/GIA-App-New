class CampusModel {
  String? success;
  String? message;
  List<CampusList>? data;

  CampusModel({this.success, this.message, this.data});

  CampusModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CampusList>[];
      json['data'].forEach((v) {
        data!.add(new CampusList.fromJson(v));
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

class CampusList {
  String? branchId;
  String? name;
  String? fullName;
  String? databaseName;
  String? location;
  String? groupOrder;

  CampusList(
      {this.branchId,
      this.name,
      this.fullName,
      this.databaseName,
      this.location,
      this.groupOrder});

  CampusList.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    name = json['name'];
    fullName = json['full_name'];
    databaseName = json['database_name'];
    location = json['location'];
    groupOrder = json['group_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['database_name'] = this.databaseName;
    data['location'] = this.location;
    data['group_order'] = this.groupOrder;
    return data;
  }
}
