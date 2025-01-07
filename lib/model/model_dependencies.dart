import 'package:get_it/get_it.dart';
import 'repository/master_data/answer_entity.dart';
import 'repository/master_data/question_entity.dart';

class ModelDependencies {
  static init(GetIt injector) {
    injector.registerFactory<QuestionEntity>(() => QuestionEntity());
    injector.registerFactory<AnswerEntity>(() => AnswerEntity());
  }
}
