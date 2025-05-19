class BuyTestModel {
  bool? success;
  String? message;
  List<GetBuyTestList>? data;

  BuyTestModel({this.success, this.message, this.data});

  BuyTestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetBuyTestList>[];
      data!.add(GetBuyTestList(
        incampus_test_fee: json['data']['incampus_test_fee'],
        online_test_fee: json['data']['online_test_fee'],
      ));
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

class GetBuyTestList {
  int? online_test_fee;
  int? incampus_test_fee;
  GetBuyTestList({
    this.online_test_fee,
    this.incampus_test_fee,
  });

  GetBuyTestList.fromJson(Map<String, dynamic> json) {
    online_test_fee = json['online_test_fee'];
    incampus_test_fee = json['incampus_test_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['online_test_fee'] = this.online_test_fee;
    data['incampus_test_fee'] = this.incampus_test_fee;
    return data;
  }
}
