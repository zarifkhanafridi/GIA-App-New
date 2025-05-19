import 'package:academy/components/reuasable_widget.dart';
import 'package:academy/data/Model/result/my_final_results.dart';
import 'package:academy/res/app_urls.dart';
import 'package:academy/res/typography.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';

import '../../../../theme/colors/light_colors.dart';

class QuizReportDetails extends StatelessWidget {
  final ResultDetails resData;

  QuizReportDetails({required this.resData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            width: 1.w,
            color: resData.correctAnswer == resData.givenAnswer
                ? Colors.green.shade300
                : Colors.red.shade300),
      ),
      padding: EdgeInsets.all(6.sp),
      child: Container(
        padding: EdgeInsets.all(4.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Question ${resData.questionNo}',
                style: CustomStyle.textRegular15
                    .copyWith(color: AppColors.kDarkBlue)),
            SizedBox(height: 5.h),
            // MarkdownBody(
            //   styleSheet: MarkdownStyleSheet(
            //     a: CustomStyle.textSemiBold15
            //         .copyWith(color: AppColors.kDarkBlue),
            //   ),
            //   data: html2md.convert(resData!.questionName.toString()),
            // ),
            Html(
              data: resData!.questionName.toString(),
            ),
            SizedBox(height: 8.h),
            _buildOptionContainer('A', resData.opt1, resData.correctAnswer!,
                resData.givenAnswer!, 'opt_1'),
            SizedBox(height: 8.h),
            _buildOptionContainer('B', resData.opt2, resData.correctAnswer!,
                resData.givenAnswer!, 'opt_2'),
            SizedBox(height: 8.h),
            _buildOptionContainer('C', resData.opt3, resData.correctAnswer!,
                resData.givenAnswer!, 'opt_3'),
            SizedBox(height: 8.h),
            _buildOptionContainer('D', resData.opt4, resData.correctAnswer!,
                resData.givenAnswer!, 'opt_4'),
            SizedBox(height: 8.h),
            Text(
              "Answer",
              style: CustomStyle.textSemiBold15
                  .copyWith(color: AppColors.kDarkBlue),
            ),
            _buildOptionContainer('D', resData.answerDescription ?? "",
                resData.correctAnswer!, resData.givenAnswer!, 'ans_desc'),
            // SizedBox(height: 5.h),
            // Text('Given Answer: ${resData.givenAnswer}',
            //     style: CustomStyle.textRegular15
            //         .copyWith(color: AppColors.kDarkBlue)),
            // SizedBox(height: 5.h),
            // Text('Correct Answer: ${resData.correctAnswer}',
            //     style: CustomStyle.textRegular15
            //         .copyWith(color: AppColors.kDarkBlue)),
            // SizedBox(height: 5.h),
            // Text(
            //   'Is Correct: ${resData.isCorrect == '1' ? 'Yes' : 'No'}',
            //   style: CustomStyle.textRegular15.copyWith(
            //       color:
            //           resData.isCorrect == '1' ? Colors.green : Colors.red),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _buildOptionContainer(String optionLabel, String? optionValue,
    String correctAnswer, String givenAnswer, String optionIndex) {
  Color bgColor =
      AppColors.kGrayscale40.withOpacity(0.5); // Default color for options
  if (optionIndex == correctAnswer) {
    bgColor = Colors.green.shade300; // Correct answer
  } else if (optionIndex == givenAnswer) {
    bgColor = Colors.red.shade300; // User's answer
  }

  return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 8.h),
      decoration: BoxDecoration(
          // color: bgColor,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: bgColor, width: 2)),
      child: Row(
        children: [
          Text(
            "($optionLabel) ",
            style:
                CustomStyle.textSemiBold15.copyWith(color: AppColors.kDarkBlue),
          ),
          Flexible(
              // child: MarkdownBody(
              //   listItemCrossAxisAlignment:
              //       MarkdownListItemCrossAxisAlignment.start,
              //   softLineBreak: true,
              //   shrinkWrap: true,
              //   styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              //   styleSheet: MarkdownStyleSheet(
              //     a: CustomStyle.textSemiBold15
              //         .copyWith(color: AppColors.whiteColor),
              //   ),
              //   data: html2md.convert(optionValue.toString()),
              // ),
              child: Html(data: optionValue!.toString())),
        ],
      ));
}

String parseString(String inputString) {
  RegExp imageTagRegExp = RegExp(r'<img src="([^"]+)"');
  var imageMatch = imageTagRegExp.firstMatch(inputString);

  if (imageMatch != null) {
    // If the regex finds an <img> tag, return the URL.
    return imageMatch.group(1)!;
  } else {
    // Otherwise, treat as HTML containing text and extract the text content.
    var document = parse(inputString);
    return document.body!.text
        .trim(); // Extracts and returns text, removing HTML tags.
  }
}
