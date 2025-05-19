import 'dart:developer';
 
import 'package:academy/View/commonPage/Login/login_screen.dart';
import 'package:academy/View/studentDashboard/student_dashbaord.dart';
import 'package:academy/ViewModel/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatefulWidget {
  AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        if (controller.isLogin.isEmpty) {
          log('user is Sign out or maybe first time');
          return LoginPage();
        } else {
          controller.initControllers();
          log('user is SignInd ');
          return HomePage();
        }
      },
    );
  }
}
