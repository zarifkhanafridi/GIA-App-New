import 'package:flutter/material.dart';
import 'package:academy/components/text_field_container.dart';
import 'package:academy/theme/colors/light_colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validator;
  final TextEditingController myController;
  const RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      required this.myController,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: myController,
        onChanged: onChanged,
        style: TextStyle(color: AppColors.kSecondaryColor),
        cursorColor: AppColors.kSecondaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: AppColors.kSecondaryColor,
          ),
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
