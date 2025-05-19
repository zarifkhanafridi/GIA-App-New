import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFFB969);
const kPrimaryLightColor = Color(0xFFFFE4C7);
const myDuration = Duration(milliseconds: 300);

var version = 'v3';
var baseUrl = 'https://qsoft.qurtuba.edu.pk/api$version/Api';
var baseUrlforAssets = 'https://qsoft.qurtuba.edu.pk/';

String method(String value) {
  double number = double.parse(value);
  print(number.toString());
  List<String>? data;
  if (number <= 0) {
    return '0.0';
  } else {
    if (value.contains('.')) {
      data = value.split('.');
      print(data[0]);
      return data[0];
    }
  }
  return '0.0';
}
