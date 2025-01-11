import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/question/question_bloc.dart';
import '../../constants.dart';

class UserReference {
  // get
  Future<double?> getGryPoint() => getLocal(PreferenceKey.gryPoint);
  Future<double?> getRavPoint() => getLocal(PreferenceKey.ravPoint);
  Future<double?> getHufPoint() => getLocal(PreferenceKey.hufPoint);
  Future<double?> getSlyPoint() => getLocal(PreferenceKey.slyPoint);
  Future<int?> getCurrentQuestion() => getLocal(PreferenceKey.currentQuestion);
  Future<String?> getStatusQuiz() => getLocal(PreferenceKey.statusQuiz);
  Future<String?> getHouseResult() => getLocal(PreferenceKey.houseResult);

  // set
  Future setGryPoint(double value) => setLocal(PreferenceKey.gryPoint, value);
  Future setRavPoint(double value) => setLocal(PreferenceKey.ravPoint, value);
  Future setHufPoint(double value) => setLocal(PreferenceKey.hufPoint, value);
  Future setSlyPoint(double value) => setLocal(PreferenceKey.slyPoint, value);
  Future setCurrentQuestion(int value) => setLocal(PreferenceKey.currentQuestion, value);
  Future setStatusQuiz(String value) => setLocal(PreferenceKey.statusQuiz, value);
  Future setHouseResult(String value) => setLocal(PreferenceKey.houseResult, value);

  Future setLocal(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  Future<T?> getLocal<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(key)) return prefs.get(key) as T?;
    return null;
  }
}
