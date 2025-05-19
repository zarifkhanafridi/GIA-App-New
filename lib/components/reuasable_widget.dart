import 'package:academy/res/typography.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 12.w,
        ),
        SizedBox(
          width: 160.w,
          child: Text(
            title,
            style: CustomStyle.textBold36.copyWith(
                color: AppColors.kDarkBlue,
                fontSize: 16.sp,
                fontWeight: mediumFontWeight),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 120.w,
          child: Text(
            value,
            style: CustomStyle.textBold36.copyWith(
                color: AppColors.kDarkBlue,
                fontSize: 17.sp,
                fontWeight: mediumFontWeight),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
