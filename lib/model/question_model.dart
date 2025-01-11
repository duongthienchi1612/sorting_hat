import 'repository/master_data/answer_entity.dart';
import 'repository/master_data/question_entity.dart';

class QuestionModel {
  final QuestionEntity question;
  final List<AnswerEntity> answers;
  final int currentQuestionId;
  final int totalQuestion;
  QuestionModel({required this.question, required this.answers, this.currentQuestionId = 1, this.totalQuestion = 1});
}
