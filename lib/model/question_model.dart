import 'package:sorting_hat/model/repository/master_data/answer_entity.dart';
import 'package:sorting_hat/model/repository/master_data/question_entity.dart';

class QuestionModel {
  final List<QuestionEntity> question;
  final List<AnswerEntity> answers;
  final int currentQuestionId;
  QuestionModel({required this.question, required this.answers, this.currentQuestionId = 1});
}
