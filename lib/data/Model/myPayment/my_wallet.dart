class myWalletModel {
  bool? success;
  String? message;
  UserBalance? data;

  myWalletModel({this.success, this.message, this.data});

  myWalletModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UserBalance.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserBalance {
  int? balance;

  UserBalance({this.balance});

  UserBalance.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    return data;
  }
}
