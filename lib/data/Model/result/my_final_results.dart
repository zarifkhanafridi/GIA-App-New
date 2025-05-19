class MyFinalResultsModel {
  bool? success;
  String? message;
  FinalTestDetail? data;

  MyFinalResultsModel({this.success, this.message, this.data});

  MyFinalResultsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new FinalTestDetail.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FinalTestDetail {
  TestDetails? testDetails;
  ResultSummery? resultSummery;
  List<ResultDetails>? resultDetails;
  List<ResultSummerySubjectWise>? resultSummerySubjectWise;

  FinalTestDetail(
      {this.testDetails,
      this.resultSummery,
      this.resultDetails,
      this.resultSummerySubjectWise});

  FinalTestDetail.fromJson(Map<String, dynamic> json) {
    testDetails = json['test_details'] != null
        ? new TestDetails.fromJson(json['test_details'])
        : null;
    resultSummery = json['result_summery'] != null
        ? new ResultSummery.fromJson(json['result_summery'])
        : null;
    if (json['result_details'] != null) {
      resultDetails = <ResultDetails>[];
      json['result_details'].forEach((v) {
        resultDetails!.add(new ResultDetails.fromJson(v));
      });
    }
    if (json['result_summery_subject_wise'] != null) {
      resultSummerySubjectWise = <ResultSummerySubjectWise>[];
      json['result_summery_subject_wise'].forEach((v) {
        resultSummerySubjectWise!.add(new ResultSummerySubjectWise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testDetails != null) {
      data['test_details'] = this.testDetails!.toJson();
    }
    if (this.resultSummery != null) {
      data['result_summery'] = this.resultSummery!.toJson();
    }
    if (this.resultDetails != null) {
      data['result_details'] =
          this.resultDetails!.map((v) => v.toJson()).toList();
    }
    if (this.resultSummerySubjectWise != null) {
      data['result_summery_subject_wise'] =
          this.resultSummerySubjectWise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestDetails {
  String? id;
  String? categoryId;
  String? testCode;
  String? testTitle;
  String? totalTime;
  String? testStart;
  String? userId;
  String? isPatternApply;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? stId;
  String? testId;

  TestDetails(
      {this.id,
      this.categoryId,
      this.testCode,
      this.testTitle,
      this.totalTime,
      this.testStart,
      this.userId,
      this.isPatternApply,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.stId,
      this.testId});

  TestDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    testCode = json['test_code'];
    testTitle = json['test_title'];
    totalTime = json['total_time'];
    testStart = json['test_start'];
    userId = json['user_id'];
    isPatternApply = json['is_pattern_apply'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stId = json['st_id'];
    testId = json['test_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['test_code'] = this.testCode;
    data['test_title'] = this.testTitle;
    data['total_time'] = this.totalTime;
    data['test_start'] = this.testStart;
    data['user_id'] = this.userId;
    data['is_pattern_apply'] = this.isPatternApply;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['st_id'] = this.stId;
    data['test_id'] = this.testId;
    return data;
  }
}

class ResultSummery {
  String? taId;
  String? stId;
  String? totalQuestions;
  String? givenAnswers;
  String? correctedAnswers;
  String? wrongAnswers;
  String? createdAt;

  ResultSummery(
      {this.taId,
      this.stId,
      this.totalQuestions,
      this.givenAnswers,
      this.correctedAnswers,
      this.wrongAnswers,
      this.createdAt});

  ResultSummery.fromJson(Map<String, dynamic> json) {
    taId = json['ta_id'];
    stId = json['st_id'];
    totalQuestions = json['total_questions'];
    givenAnswers = json['given_answers'];
    correctedAnswers = json['corrected_answers'];
    wrongAnswers = json['wrong_answers'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ta_id'] = this.taId;
    data['st_id'] = this.stId;
    data['total_questions'] = this.totalQuestions;
    data['given_answers'] = this.givenAnswers;
    data['corrected_answers'] = this.correctedAnswers;
    data['wrong_answers'] = this.wrongAnswers;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class ResultDetails {
  String? id;
  String? testId;
  String? questionNo;
  String? questionName;
  String? opt1;
  String? opt2;
  String? opt3;
  String? opt4;
  String? correctAnswer;
  String? answerDescription;
  String? createdAt;
  String? updatedAt;
  String? taId;
  String? userId;
  String? qId;
  String? givenAnswer;
  String? correctedAnswer;
  String? isCorrect;

  ResultDetails(
      {this.id,
      this.testId,
      this.questionNo,
      this.questionName,
      this.opt1,
      this.opt2,
      this.opt3,
      this.opt4,
      this.correctAnswer,
      this.answerDescription,
      this.createdAt,
      this.updatedAt,
      this.taId,
      this.userId,
      this.qId,
      this.givenAnswer,
      this.correctedAnswer,
      this.isCorrect});

  ResultDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    testId = json['test_id'];
    questionNo = json['question_no'];
    questionName = json['question_name'];
    opt1 = json['opt_1'];
    opt2 = json['opt_2'];
    opt3 = json['opt_3'];
    opt4 = json['opt_4'];
    correctAnswer = json['correct_answer'];
    answerDescription = json['ans_desc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    taId = json['ta_id'];
    userId = json['user_id'];
    qId = json['q_id'];
    givenAnswer = json['given_answer'];
    correctedAnswer = json['corrected_answer'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['test_id'] = this.testId;
    data['question_no'] = this.questionNo;
    data['question_name'] = this.questionName;
    data['opt_1'] = this.opt1;
    data['opt_2'] = this.opt2;
    data['opt_3'] = this.opt3;
    data['opt_4'] = this.opt4;
    data['correct_answer'] = this.correctAnswer;
    data['ans_desc'] = this.answerDescription;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ta_id'] = this.taId;
    data['user_id'] = this.userId;
    data['q_id'] = this.qId;
    data['given_answer'] = this.givenAnswer;
    data['corrected_answer'] = this.correctedAnswer;
    data['is_correct'] = this.isCorrect;
    return data;
  }
}

class ResultSummerySubjectWise {
  String? subject;
  int? c;
  int? w;

  ResultSummerySubjectWise({this.subject, this.c, this.w});

  ResultSummerySubjectWise.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    c = json['C'];
    w = json['W'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['C'] = this.c;
    data['W'] = this.w;
    return data;
  }
}
