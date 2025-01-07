import 'repository/master_data/answer_entity.dart';
import 'repository/master_data/question_entity.dart';

class QuestionModel {
  final List<QuestionEntity> question;
  final List<AnswerEntity> answers;
  final int currentQuestionId;
  QuestionModel({required this.question, required this.answers, this.currentQuestionId = 1});
}
