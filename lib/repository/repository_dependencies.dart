import 'package:get_it/get_it.dart';
import 'package:sorting_hat/repository/interface/answer_repository.dart';
import 'package:sorting_hat/repository/interface/question_repository.dart';
import 'package:sorting_hat/repository/master_data/answer_repository.dart';
import 'package:sorting_hat/repository/master_data/question_repository.dart';

class RepositoryDependencies {
  static init(GetIt injector) {
    injector.registerLazySingleton<IQuestionRepository>(() => QuestionRepository());
    injector.registerLazySingleton<IAnswerRepository>(() => AnswerRepository());
  }
}
