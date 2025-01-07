import 'package:get_it/get_it.dart';
import 'question_screen.dart';

class ScreenDependencies {
  static void init(GetIt injector) {
    injector.registerFactory<QuestionScreen>(() => const QuestionScreen());
  }
}
