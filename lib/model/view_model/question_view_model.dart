import 'answer_model.dart';
import 'question_model.dart';

class QuestionViewModel {
  final QuestionModel question;
  final List<AnswerModel> answers;
  final int currentQuestionId;
  final int totalQuestion;
  QuestionViewModel({required this.question, required this.answers, this.currentQuestionId = 1, this.totalQuestion = 1});
}
