import 'package:academy/data/Model/pronunciation_model.dart';

class QuizModel {
  String quizId;
  String languageId;
  String quizName;
  String quizDescription;
  LanguageLevel languageLevel;
  List<Pronunciation> questions;
  QuizModel({
    required this.quizId,
    required this.languageId,
    required this.quizName,
    required this.quizDescription,
    required this.languageLevel,
    required this.questions,
  });
}

enum LanguageLevel { Beginner, Intermediate, Advanced }

QuizModel quizModel = QuizModel(
  quizId: "quiz1",
  languageId: 'English',
  quizName: 'English 1',
  quizDescription: 'Test desc',
  languageLevel: LanguageLevel.Beginner,
  questions: [
    pronunciation1,
    pronunciation2,
    pronunciation3,
    pronunciation4,
    pronunciation5,
    pronunciation6
  ],
);
