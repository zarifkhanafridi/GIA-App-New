import 'package:flutter/material.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  TextEditingController? textEditingController = TextEditingController();
  final Color borderColor;
  String label;
  DatePicker({
    this.textEditingController,
    required this.label,
    required this.borderColor,
  });

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;
//  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please provide date';
          } else {
            return null;
          }
        },
        style: TextStyle(
          color: widget.borderColor,
        ),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 1)),
            suffixIcon: Icon(Icons.calendar_today, color: widget.borderColor),
            labelText: widget.label,
            labelStyle: TextStyle(color: widget.borderColor)

            // icon: Icon(Icons.calendar)
            ),
        focusNode: AlwaysDisabledFocusNode(),
        controller: widget.textEditingController,
        onTap: () {
          _selectDate(context);
        },
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate;
    newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
                primary: AppColors.kSecondaryColor,
                onPrimary: AppColors.kPrimaryColor,
                surface: AppColors.kRed,
                onSurface: Colors.white
                // primary: Colors.deepPurple,
                // onPrimary: Colors.white,
                // surface: Colors.blueGrey,
                // onSurface: Colors.yellow,
                ),
            dialogBackgroundColor: AppColors.kPrimaryColor,
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;

      widget.textEditingController!
        //    _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: widget.textEditingController!.text.length,

//            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
