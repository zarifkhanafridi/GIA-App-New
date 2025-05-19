// import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tablePayment = 'tablePayment';
const String paymentId = 'paymentId';
const String paymentStudentName = 'paymentStudentName';
const String paymentStudentReg = 'paymentStudentReg';
const String paymentNetAmount = 'paymentNetAmount';
const String paymentStatus = 'paymentStatus';

const String tableProductsDetails = 'tableProductsDetails';
const String productId = 'productId';
const String productName = 'productName';
const String productDescription = 'productDescription';
const String productQty = 'productQty';
const String productPrice = 'productPrice';

class DBHelper {
  DBHelper.internal();
  static final DBHelper instance = DBHelper.internal();
  factory DBHelper() => instance;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();

    return _db!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'gia.db');

    Database openDb = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
                          create table $tablePayment ( 
                            $paymentId text primary key, 
                            $paymentStudentName text not null,
                            $paymentStudentReg text not null,
                            $paymentStatus text not null,
                            $paymentNetAmount REAL not null
                            )
                          """);

        await db.execute("""
                          create table $tableProductsDetails ( 
                            $productId text primary key, 
                            $paymentId text not null, 
                            $productName text not null,
                            $productDescription text not null,
                            $productQty integer not null,
                            $productPrice REAL not null
                            )
                          """);
      },
    );

    return openDb;
  }
}

class Controller {
  final conn = DBHelper.instance;

  // **************** Functions for Payment Table **************************
  Future<int> insertIntoPayment(PaymentModel paymentModel) async {
    var db = await conn.db;
    var res = await db.insert(tablePayment, paymentModel.toJson());
    return res;
  }

  Future<List<PaymentModel>> getPayments() async {
    var db = await conn.db;
    List<Map<String, Object?>> maps = await db.query(tablePayment);
    List<PaymentModel> payments =
        maps.map((e) => PaymentModel.fromJson(e)).toList();
    return payments;
  }

  Future<int> deletePaymentById(String id) async {
    var db = await conn.db;
    return await db
        .delete(tablePayment, where: '$paymentId = ?', whereArgs: [id]);
  }

  Future<int> updatePaymentById(PaymentModel paymentModel) async {
    var db = await conn.db;
    return await db.update(tablePayment, paymentModel.toJson(),
        where: '$paymentId = ?', whereArgs: [paymentModel.paymentId]);
  }

  // **************** Functions for Product Table **************************
  Future<void> insertIntoProductsDetails(
      ProductDetailsModel productDetailsModel) async {
    var db = await conn.db;
    var res =
        await db.insert(tableProductsDetails, productDetailsModel.toJson());
    print(res);
  }

  Future<List<ProductDetailsModel>> getProductsDetails() async {
    var db = await conn.db;
    List<Map<String, Object?>> maps = await db.query(tableProductsDetails);
    List<ProductDetailsModel> products =
        maps.map((e) => ProductDetailsModel.fromJson(e)).toList();
    return products;
  }

  Future<int> deleteProductById(String id) async {
    var db = await conn.db;
    return await db
        .delete(tableProductsDetails, where: '$productId = ?', whereArgs: [id]);
  }

  Future<int> deleteProductByPaymentId(String id) async {
    var db = await conn.db;
    return await db
        .delete(tableProductsDetails, where: '$paymentId = ?', whereArgs: [id]);
  }

  Future<int> updateProductById(ProductDetailsModel productDetailsModel) async {
    var db = await conn.db;
    return await db.update(tableProductsDetails, productDetailsModel.toJson(),
        where: '$productId = ?', whereArgs: [productDetailsModel.productId]);
  }

  Future<void> closeDB() async {
    var db = await conn.db;
    await db.close();
  }
}

///////////////////////

class PaymentModel {
  final String paymentId;
  final String paymentStudentName;
  final String paymentStudentReg;
  final String paymentStatus;
  final double paymentNetAmount;

  PaymentModel({
    required this.paymentId,
    required this.paymentStudentName,
    required this.paymentStudentReg,
    required this.paymentStatus,
    required this.paymentNetAmount,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      paymentId: json['paymentId'],
      paymentStudentName: json['paymentStudentName'],
      paymentStudentReg: json['paymentStudentReg'],
      paymentStatus: json['paymentStatus'],
      paymentNetAmount: json['paymentNetAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "paymentId": paymentId,
      "paymentStudentName": paymentStudentName,
      "paymentStudentReg": paymentStudentReg,
      "paymentStatus": paymentStatus,
      "paymentNetAmount": paymentNetAmount,
    };
  }
}

class ProductDetailsModel {
  final String productId;
  final String paymentId;
  final String productName;
  final String productDescription;
  final int productQty;
  final double productPrice;

  ProductDetailsModel({
    required this.productId,
    required this.paymentId,
    required this.productName,
    required this.productDescription,
    required this.productQty,
    required this.productPrice,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      productId: json['productId'],
      paymentId: json['paymentId'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productQty: json['productQty'],
      productPrice: json['productPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'paymentId': paymentId,
      'productName': productName,
      'productDescription': productDescription,
      'productQty': productQty,
      'productPrice': productPrice,
    };
  }
}
