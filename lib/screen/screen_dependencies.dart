import 'package:get_it/get_it.dart';
import 'package:sorting_hat/screen/question_screen.dart';

class ScreenDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<QuestionScreen>(() => const QuestionScreen());
  }
}
