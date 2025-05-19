import 'package:flutter/material.dart';
import 'package:academy/components/text_field_container.dart';
import 'package:academy/theme/colors/light_colors.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController myController;
  final String? Function(String?)? validator;
  final String? hintText;
  const RoundedPasswordField({
    Key? key,
    this.validator,
    this.hintText = 'Password',
    required this.onChanged,
    required this.myController,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool? status;

  @override
  void initState() {
    //

    status = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: widget.myController,
        obscureText: status!, //  bool variable
        onChanged: widget.onChanged,
        style: TextStyle(color: AppColors.kSecondaryColor),
        cursorColor: AppColors.kSecondaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText!,
          hintStyle: TextStyle(
            color: AppColors.kSecondaryColor,
          ),
          icon: Icon(
            Icons.lock,
            color: AppColors.kSecondaryColor,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          // color: kPrimaryColor,
          // ),
          suffixIcon: SizedBox(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: status == true
                  ? () {
                      status = false;
                      setState(() {});
                    }
                  : () {
                      status = true;
                      setState(() {});
                    },
              icon: status == true
                  ? Icon(Icons.remove_red_eye_outlined,
                      color: AppColors.kSecondaryColor)
                  : Icon(Icons.remove_red_eye,
                      color: AppColors.kSecondaryColor),
            ),
          ),

          border: InputBorder.none,
        ),
        validator: widget.validator,
      ),
    );
  }
}
