class InvoiceModel {
  bool? success;
  String? message;
  List<InvoiceDetail>? data;

  InvoiceModel({this.success, this.message, this.data});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <InvoiceDetail>[];
      json['data'].forEach((v) {
        data!.add(new InvoiceDetail.fromJson(v));
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

class InvoiceDetail {
  int? id;
  String? product;
  String? groupId;
  String? categoryId;
  String? courseId;
  String? qty;
  String? price;
  String? discount;
  String? feeType;

  InvoiceDetail({
    this.id,
    this.product,
    this.groupId,
    this.categoryId,
    this.courseId,
    this.qty,
    this.price,
    this.discount,
    this.feeType,
  });

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    groupId = json['group_id'];
    categoryId = json['category_id'];
    courseId = json['course_id'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    feeType = json['fee_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = id;
    data['product'] = product;
    data['group_id'] = groupId;
    data['category_id'] = categoryId;
    data['course_id'] = courseId;
    data['qty'] = qty;
    data['price'] = price;
    data['discount'] = discount;
    data['fee_type'] = feeType;
    return data;
  }
}
