import 'dart:io';

import 'package:flutter/material.dart';
import 'package:academy/View/commonPage/Login/components/body.dart';
import 'package:upgrader/upgrader.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UpgradeAlert(
        shouldPopScope: () => true,
        canDismissDialog: true,
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        upgrader: Upgrader(
          durationUntilAlertAgain: Duration(days: 1),
        ),
        child: Body(),
      ),
    );
  }
}
