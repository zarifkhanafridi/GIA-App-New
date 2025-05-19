class NoticeBoard {
  String? success;
  String? message;
  List<NoticeBoardList>? data;

  NoticeBoard({this.success, this.message, this.data});

  NoticeBoard.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <NoticeBoardList>[];
      json['data'].forEach((v) {
        data!.add(new NoticeBoardList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NoticeBoardList {
  String? noticeId;
  String? noticeTitle;
  String? noticeDesc;
  String? noticeDate;
  String? noticeStatus;
  String? titleColor;

  NoticeBoardList(
      {this.noticeId,
      this.noticeTitle,
      this.noticeDesc,
      this.noticeDate,
      this.noticeStatus,
      this.titleColor});

  NoticeBoardList.fromJson(Map<String, dynamic> json) {
    noticeId = json['notice_id'];
    noticeTitle = json['notice_title'];
    noticeDesc = json['notice_desc'];
    noticeDate = json['notice_date'];
    noticeStatus = json['notice_status'];
    titleColor = json['title_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notice_id'] = this.noticeId;
    data['notice_title'] = this.noticeTitle;
    data['notice_desc'] = this.noticeDesc;
    data['notice_date'] = this.noticeDate;
    data['notice_status'] = this.noticeStatus;
    data['title_color'] = this.titleColor;
    return data;
  }
}
