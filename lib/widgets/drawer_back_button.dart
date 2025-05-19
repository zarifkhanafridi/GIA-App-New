import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';

class DrawerBackButton extends StatelessWidget {
  final Widget? screen;

  DrawerBackButton({Key? key, this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return screen ?? SizedBox();
          }));
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: AppColors.kDarkBlue,
          ),
        ),
      ),
    );
  }
}
