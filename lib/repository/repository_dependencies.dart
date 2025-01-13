import 'package:get_it/get_it.dart';
import 'interface/answer_repository.dart';
import 'interface/question_repository.dart';
import 'master_data/answer_repository.dart';
import 'master_data/question_repository.dart';

class RepositoryDependencies {
  static void init(GetIt injector) {
    injector.registerLazySingleton<IQuestionRepository>(() => QuestionRepository());
    injector.registerLazySingleton<IAnswerRepository>(() => AnswerRepository());
  }
}
