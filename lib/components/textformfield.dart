import 'package:flutter/material.dart';
import 'package:academy/components/text_field_container.dart';

import '../theme/colors/light_colors.dart';

class TextForm extends StatelessWidget {
  final String hintText;
  final int maxLines;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController myController;
  const TextForm(
      {Key? key,
      required this.maxLines,
      required this.hintText,
      required this.onChanged,
      required this.myController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextFormField(
        maxLines: maxLines,
        controller: myController,
        onChanged: onChanged,
        style: TextStyle(color: AppColors.kSecondaryColor),
        cursorColor: AppColors.kSecondaryColor,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.kSecondaryColor,
          ),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}
