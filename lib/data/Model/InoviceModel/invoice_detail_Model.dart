class InvoiceDetailModel {
  bool? success;
  String? message;
  InvoiceData? data;

  InvoiceDetailModel({
    this.success,
    this.message,
    this.data,
  });

  factory InvoiceDetailModel.fromJson(Map<String, dynamic> json) =>
      InvoiceDetailModel(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: InvoiceData.fromJson(json['data'] as Map<String, dynamic>),
      );
}

class InvoiceData {
  final InvoiceDetails? inv;
  final List<PaymentMethod>? pMethods;

  InvoiceData({
    this.inv,
    this.pMethods,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) => InvoiceData(
        inv: InvoiceDetails.fromJson(json['inv'] as Map<String, dynamic>),
        pMethods: List<PaymentMethod>.from(
          (json['p_methods'] as List).map((x) => PaymentMethod.fromJson(x)),
        ),
      );
}

class InvoiceDetails {
  int? id;
  String? refId;
  String? userId;
  String? createdBy;
  String? status;
  String? createdAt;
  String? createFromPlace;
  String? updatedAt;
  String? uploadedReceipt;
  String? uploadedReceiptDate;
  String? invoiceAmount;
  String? otherCharges;
  String? otherChargesDesc;
  String? discount;
  String? invoiceTotalAmount;
  User? user;
  List<InvoiceDetail>? invoiceDetil;

  InvoiceDetails({
    this.id,
    this.refId,
    this.userId,
    this.createdBy,
    this.status,
    this.createdAt,
    this.createFromPlace,
    this.updatedAt,
    this.uploadedReceipt,
    this.uploadedReceiptDate,
    this.invoiceAmount,
    this.otherCharges,
    this.otherChargesDesc,
    this.discount,
    this.invoiceTotalAmount,
    this.user,
    this.invoiceDetil,
  });
  InvoiceDetails.fromJson(Map<String, dynamic> json) {
    List<InvoiceDetail> invoiceDet = [];
    if (json['invoice_detil'] != null) {
      for (var invoice in json['invoice_detil']) {
        invoiceDet.add(InvoiceDetail.fromJson(invoice));
      }
    }

    id = json['id'];
    refId = json['ref_id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    status = json['status'];
    createdAt = json['created_at'];
    createFromPlace = json['create_from_place'];
    updatedAt = json['updated_at'];
    uploadedReceipt = json['uploaded_receipt'];
    uploadedReceiptDate = json['uploaded_receipt_date'];
    invoiceAmount = json['invoice_amount'];
    otherCharges = json['other_charges'];
    otherChargesDesc = json['other_charges_desc'];
    discount = json['discount'];
    invoiceTotalAmount = json['invoice_total_amount'];
    user = User.fromJson(json['user'] as Map<String, dynamic>);
    invoiceDetil = invoiceDet;
  }
}

class InvoiceDetail {
  int? id;
  String? invoice_id;
  String? group_id;
  String? category_id;
  String? course_id;
  String? book_id;
  String? qty;
  String? price;
  String? discount;
  String? fee_type;
  String? created_at;
  String? updated_at;
  Category? category;
  Groups? groups;
  Course? course;

  InvoiceDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoice_id = json['invoice_id'];
    group_id = json['group_id'];
    category_id = json['category_id'];
    course_id = json['course_id'];
    book_id = json['book_id'];
    qty = json['qty'];
    price = json['price'];
    discount = json['discount'];
    fee_type = json['fee_type'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    groups = json['groups'] != null ? Groups.fromJson(json['groups']) : null;
    course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }
}

class Category {
  int? id;
  String? master_category_id;
  String? group_id;
  String? name;
  String? slug;
  String? icon_class;
  String? is_active;
  String? created_at;
  String? updated_at;
  MasterCategory? master_category;

  Category.fromJson(json) {
    id = json['id'];
    master_category_id = json['master_category_id'];
    group_id = json['group_id'];
    name = json['name'];
    slug = json['slug'];
    icon_class = json['icon_class'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    master_category = MasterCategory.fromJson(json['master_category']);
  }
}

class MasterCategory {
  int? id;
  String? name;
  String? slug;
  String? icon_class;
  String? is_active;
  String? created_at;
  String? updated_at;
  String? image;
  MasterCategory.fromJson(json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    icon_class = json['icon_class'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    image = json['image'];
  }
}

class Groups {
  int? id;
  String? group_code;
  String? name;
  String? registration_method;
  String? description;
  String? is_active;
  String? total_seat;
  String? expire_on;
  String? group_type;

  Groups.fromJson(json) {
    id = json['id'];
    group_code = json['group_code'];
    name = json['name'];
    registration_method = json['registration_method'];
    description = json['description'];
    is_active = json['is_active'];
    total_seat = json['total_seat'];
    expire_on = json['expire_on'];
    group_type = json['group_type'];
  }
}

class Course {
  int? id;
  String? instructor_id;
  String? category_id;
  String? master_course_id;
  String? instruction_level_id;
  String? course_code;
  String? course_title;
  String? course_overview_url;
  String? course_slug;
  String? keywords;
  String? overview;
  String? course_image;
  String? thumb_image;
  String? course_video;
  String? duration;
  String? price;
  String? class_time;
  String? strike_out_price;
  String? is_active;
  String? created_at;
  String? updated_at;
  MasterCourse? master_course;

  Course.fromJson(json) {
    id = json['id'];
    instructor_id = json['instructor_id'];
    category_id = json['category_id'];
    master_course_id = json['master_course_id'];
    instruction_level_id = json['instruction_level_id'];
    course_code = json['course_code'];
    course_title = json['course_title'];
    course_overview_url = json['course_overview_url'];
    course_slug = json['course_slug'];
    keywords = json['keywords'];
    overview = json['overview'];
    course_image = json['course_image'];
    thumb_image = json['thumb_image'];
    course_video = json['course_video'];
    duration = json['duration'];
    price = json['price'];
    class_time = json['class_time'];
    strike_out_price = json['strike_out_price'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    master_course = MasterCourse.fromJson(json['master_course']);
  }
}

class MasterCourse {
  int? id;
  String? instructor_id;
  String? category_id;
  String? instruction_level_id;
  String? course_title;
  String? course_slug;
  String? keywords;
  String? overview;
  String? course_image;
  String? thumb_image;
  String? course_video;
  String? duration;
  String? price;
  String? strike_out_price;
  String? is_active;
  String? created_at;
  String? updated_at;

  MasterCourse.fromJson(json) {
    id = json['id'];
    instructor_id = json['instructor_id'];
    category_id = json['category_id'];
    instruction_level_id = json['instruction_level_id'];
    course_title = json['course_title'];
    course_slug = json['course_slug'];
    keywords = json['keywords'];
    overview = json['overview'];
    course_image = json['course_image'];
    thumb_image = json['thumb_image'];
    course_video = json['course_video'];
    duration = json['duration'];
    price = json['price'];
    strike_out_price = json['strike_out_price'];
    is_active = json['is_active'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }
}

class User {
  int? id;
  String? firstName;
  String? fName;
  String? gender;
  String? email;
  String? isActive;
  String? createdAt;
  String? updatedAt;
  String? regNo;
  String? retriveUniqCode;
  String? cardExpireAt;
  String? contactNo;
  String? commission;
  String? deviceImei;
  String? biography;
  String? image;
  String? shortDesc;

  User({
    this.id,
    this.firstName,
    this.fName,
    this.gender,
    this.email,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.regNo,
    this.biography,
    this.cardExpireAt,
    this.commission,
    this.contactNo,
    this.deviceImei,
    this.image,
    this.retriveUniqCode,
    this.shortDesc,

    // required this.retrive,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    firstName = json['first_name'];
    fName = json['fname'];
    gender = json['gender'];
    email = json['email'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    regNo = json['reg_no'];
    retriveUniqCode = json['retrive_uniq_code'];
    cardExpireAt = json['card_expire_at'];
    contactNo = json['contact_no'];
    commission = json['commission'];
    deviceImei = json['device_imei'];
    biography = json['biography'];
    image = json['image'];
    shortDesc = json['short_desc'];
  }
}

class PaymentMethod {
  int? id;
  String? payment_title;
  String? pay_method;
  String? unique_code;
  String? status;
  String? description;
  String? pay_details_deletion;
  String? slab_charges;

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payment_title = json['payment_title'];
    pay_method = json['pay_method'];
    unique_code = json['unique_code'];
    status = json['status'];
    description = json['description'];
    pay_details_deletion = json['pay_details_deletion'];
    slab_charges = json['slab_charges'];
  }
}
