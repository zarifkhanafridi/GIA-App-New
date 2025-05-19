import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';

class Background extends StatelessWidget {
  final Widget child;
  final bool? isAuth;
  const Background({
    Key? key,
    this.isAuth,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.kSecondaryColor,
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
              color: AppColors.kDarkBlue,
            ),
          ),
          isAuth == false
              ? SizedBox.fromSize()
              : Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/login_bottom.png",
                    width: size.width * 0.4,
                    color: AppColors.kDarkBlue,
                  ),
                ),
          child,
        ],
      ),
    );
  }
}
