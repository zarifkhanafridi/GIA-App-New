import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final bool? message;
  final Widget child;
  const ErrorMessage({Key? key, this.message, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi,
              size: size.width * 0.1,
            ),
            Text(
              'Opps',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.05,
                color: Colors.red,
              ),
            ),
            Text(
              'No Internet Connection',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.035,
                //color: LightColors.kDarkYellow
              ),
            ),
            Text(
              'Check Internet Connection & Tap button',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: size.width * 0.035,
                //color: LightColors.kDarkYellow
              ),
            ),
            SizedBox(
              height: 5,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
