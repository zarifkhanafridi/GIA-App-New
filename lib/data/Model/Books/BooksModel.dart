class GetMyBooksModel {
  bool? success;
  String? message;
  List<GetMyBooksList>? data;

  GetMyBooksModel({this.success, this.message, this.data});

  GetMyBooksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetMyBooksList>[];
      json['data'].forEach((v) {
        data!.add(new GetMyBooksList.fromJson(v));
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

class GetMyBooksList {
  String? file_path;
  int? id;
  String? title;
  String? description;
  String? qty;
  String? price;
  String? active;
  String? created_at;
  String? updated_at;

  GetMyBooksList({
    this.file_path,
    this.id,
    this.title,
    this.description,
    this.qty,
    this.price,
    this.active,
    this.created_at,
    this.updated_at,
  });

  factory GetMyBooksList.fromJson(Map<String, dynamic> json) {
    return GetMyBooksList(
      file_path: json['file_path'],
      id: json['id'],
      title: json['title'],
      description: json['description'],
      qty: json['qty'],
      price: json['price'],
      active: json['active'],
      created_at: json['created_at'],
      updated_at: json[' updated_at'],
    );
  }
  Map<String, dynamic> toJson() => {
        "file_path": file_path,
        "id": id,
        "title": title,
        "description": description,
        "qty": qty,
        "price": price,
        "active": active,
        "created_at": created_at,
        "updated_at": updated_at,
      };
}

List<GetMyBooksList> list = [];
