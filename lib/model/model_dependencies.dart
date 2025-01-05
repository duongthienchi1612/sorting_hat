import 'package:get_it/get_it.dart';
import 'package:sorting_hat/model/repository/master_data/answer_entity.dart';
import 'package:sorting_hat/model/repository/master_data/question_entity.dart';

class ModelDependencies {
  static init(GetIt injector) {
    injector.registerFactory<QuestionEntity>(() => QuestionEntity());
    injector.registerFactory<AnswerEntity>(() => AnswerEntity());
  }
}
