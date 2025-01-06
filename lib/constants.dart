class Database {
  static const questionTable = 'questions';
  static const answerTable = 'answers';
}

class QuestionType {
  static const alternative = 'Alternative';
}

class PreferenceKey {
  static const gryPoint = 'GRY_POINT';
  static const ravPoint = 'RAV_POINT';
  static const hufPoint = 'HUF_POINT';
  static const slyPoint = 'SLY_POINT';
}

class ImagePath {
  static const gryImage = 'assets/images/gry_trans.png';
  static const ravImage = 'assets/images/rav_trans.png';
  static const hufImage = 'assets/images/huf_trans.png';
  static const slyImage = 'assets/images/sly_trans.png';

  static const houses = [gryImage, ravImage, hufImage, slyImage];
}
