import 'package:academy/View/commonPage/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/Model/single_topic.dart';
import '../../../theme/colors/light_colors.dart';

class SingleListViewVideo extends StatefulWidget {
  final String? subject;
  final String? id;
  const SingleListViewVideo({super.key, this.subject, this.id});

  @override
  State<SingleListViewVideo> createState() => _SingleListViewVideoState();
}

class _SingleListViewVideoState extends State<SingleListViewVideo> {
  // OnlineClassController onlineClassController =
  //     Get.put(OnlineClassController());

  List<VideoModel> videoList = [
    VideoModel(videoLink: 'video_link_1'),
    VideoModel(videoLink: 'video_link_2'),
    // Add more items as needed
    VideoModel(videoLink: 'video_link_10'),
    VideoModel(videoLink: 'video_link_11'),
    // Add more items as needed
    // ...
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
          title: Text(
            'Video ',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   singleTopic.data.subCouDetTitle.toString(),
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  primary: false,
                  itemCount: videoList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Get.to(() => SingleTopicPage(
                        //       id: widget.id,
                        //       subject: widget.subject,
                        //       videoLink: snapshot.data!.data.videos[index],
                        //     ));
                      },
                      child: Card(
                        color: Color(0xFF103CE7).withOpacity(0.5),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              height: 30,
                              child: Center(
                                child: Text(
                                  'Videos No  :   ${index + 1} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoModel {
  final String videoLink;

  VideoModel({
    required this.videoLink,
  });
}
