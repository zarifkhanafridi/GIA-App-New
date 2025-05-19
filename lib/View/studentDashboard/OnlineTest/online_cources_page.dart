// ignore_for_file: close_sinks

import 'package:academy/View/commonPage/background.dart';
import 'package:academy/View/studentDashboard/Courses/single_list_video_screen.dart';
import 'package:academy/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnlineCourcesPage extends StatefulWidget {
  final String subjectName;
  // final String subjectId;
  // final String gradeId;

  const OnlineCourcesPage(this.subjectName);

  @override
  State<OnlineCourcesPage> createState() => _OnlineCourcesPageState();
}

class _OnlineCourcesPageState extends State<OnlineCourcesPage> {
  final ScrollController _scrollController = ScrollController();
  // OnlineClassController onlineClassController =
  //     Get.put(OnlineClassController());
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Background(
      child: Scaffold(
        // appBar: PreferredSize(
        //     child: MyBackButton(
        //         onTab: () => Get.back(),
        //         opacity: closeTopContainer == false ? 0 : 1,
        //         title: widget.subjectName),
        //     preferredSize: Size(40, 52)),
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.kPrimaryColor,
                  AppColors.kPrimaryColor,
                ],
              ),
            ),
          ),
          title: Text(
            'Online test',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: AppColors.kSecondaryColor,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Scrollbar(
            thickness: 6,
            radius: Radius.circular(3),
            controller: _scrollController,
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      padding: EdgeInsets.zero,
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 6,
                          maxCrossAxisExtent: 192,
                          childAspectRatio: 5 / 6),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: courseList.length,
                      itemBuilder: (context, index) {
                        var singleCourseList = courseList[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => SingleListViewVideo(
                                  subject: widget.subjectName,
                                  id: singleCourseList.subCouDetId.toString(),
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.kDarkBlue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                      child: Text(
                                    singleCourseList.chapter ?? 'chapter Empty',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: size.width * 0.04,
                                        letterSpacing: 0.2,
                                        color: Colors.white),
                                  )),
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: RichText(
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontSize: size.width * 0.03,
                                                color: Colors.white),
                                            text: singleCourseList
                                                .subCouDetTitle)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      top: BorderSide(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    )),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Icon(
                                            Icons.video_label_outlined,
                                            color: Colors.white,
                                            size: size.width * 0.040,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Watch Video',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 22,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<SingleCourseModel> courseList = [
    SingleCourseModel(
      subCouDetId: 1,
      chapter: 'Chapter 1',
      subCouDetTitle: 'Introduction to Flutter',
    ),
    SingleCourseModel(
      subCouDetId: 2,
      chapter: 'Chapter 2',
      subCouDetTitle: 'Building UI with Widgets',
    ),
    // Add more items as needed
    SingleCourseModel(
      subCouDetId: 11,
      chapter: 'Chapter 11',
      subCouDetTitle: 'Advanced Flutter Concepts',
    ),
    SingleCourseModel(
      subCouDetId: 12,
      chapter: 'Chapter 12',
      subCouDetTitle: 'State Management in Flutter',
    ),
  ];
}

class SingleCourseModel {
  final int subCouDetId;
  final String chapter;
  final String subCouDetTitle;

  SingleCourseModel({
    required this.subCouDetId,
    required this.chapter,
    required this.subCouDetTitle,
  });
}
