import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';

class MyBackButton extends StatelessWidget {
  final Widget? child;
  final double? opacity;
  final String? title;
  final VoidCallback onTab;

  const MyBackButton(
      {Key? key, this.child, this.title, this.opacity, required this.onTab})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Hero(
          tag: 'backButton',
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: onTab,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 2),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 5, 2, 5),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: AppColors.kDarkBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          width: 10,
        ),
        // child,
        Text(
          title ?? 'title Empty',
          style: TextStyle(
              fontSize:
                  size.width > 600 ? size.width * 0.02 : size.width * 0.05,
              //fontSize: size.width * 0.035,

              fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
