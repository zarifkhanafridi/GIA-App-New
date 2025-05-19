import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveProjectsCard extends StatelessWidget {
  final String title;

  final String image;
  final void Function()? onTap;
  const ActiveProjectsCard(
      {super.key, required this.title, required this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
        ),
        color: AppColors.kPrimaryColor,
        child: Container(
          padding: EdgeInsets.all(17),
          margin: EdgeInsets.symmetric(vertical: 1.2.h, horizontal: 1.2.w),

          //height: size.height * 0.28,
          decoration: BoxDecoration(
            color: AppColors.kSecondaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(7.r),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 35.w,
                height: 35.h,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                title,
                style: CustomStyle.textRegular15,
              ),
              Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
      ),
    );
  }
}
