import 'package:flutter/material.dart';
import 'package:academy/util/constants.dart';

class RoundedButton extends StatelessWidget {
  final Widget childWidget;
  final VoidCallback press;
  final Color color;
  const RoundedButton({
    Key? key,
    required this.childWidget,
    required this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(17),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          onPressed: press,
          child: childWidget,
        ),
      ),
    );
  }
}
