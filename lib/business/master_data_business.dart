import 'package:sorting_hat/dependencies.dart';
import 'package:sorting_hat/model/repository/master_data/answer_entity.dart';
import 'package:sorting_hat/model/repository/master_data/question_entity.dart';
import 'package:sorting_hat/repository/interface/answer_repository.dart';
import 'package:sorting_hat/repository/interface/question_repository.dart';

class MasterDataBusiness {
  List<QuestionEntity>? questions;
  List<AnswerEntity>? answers;

  final _questionRepository = injector.get<IQuestionRepository>();
  final _answerRepository = injector.get<IAnswerRepository>();

  MasterDataBusiness();

  Future init() async {
    questions = await _questionRepository.listAll();
    answers = await _answerRepository.listAll();
  }
}
