import 'package:get_it/get_it.dart';
import 'package:sorting_hat/bloc/question/question_bloc.dart';

class BlocDependencies {
  static init(GetIt injector) {
    injector.registerFactory<QuestionBloc>(() => QuestionBloc());
  }
}