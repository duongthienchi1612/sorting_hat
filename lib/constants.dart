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
  static const currentQuestion = 'CURRENT_QUESTION';
  static const statusQuiz = 'STATUS_QUIZ';
  static const houseResult = 'HOUSE_RESULT';
  static const language = 'LANGUAGE';
}

class ImagePath {
  static const gryImage = 'assets/images/gry_trans.png';
  static const ravImage = 'assets/images/rav_trans.png';
  static const hufImage = 'assets/images/huf_trans.png';
  static const slyImage = 'assets/images/sly_trans.png';
  static const background_question = 'assets/images/background_question.png';
  static const background_result = 'assets/images/background_result.png';
  static const splash_screen = 'assets/images/splash_screen.png';
  static const icon_hat = 'assets/images/icon_hat.png';

  static const houses = [gryImage, ravImage, hufImage, slyImage];

  static const allImage = [
    gryImage,
    ravImage,
    hufImage,
    slyImage,
    background_question,
    background_result,
    splash_screen,
    icon_hat
  ];
}

class StatusQuiz {
  static const done = 'DONE';
  static const inProgress = 'INPROGRESS';
}

class HouseName {
  static const gryffindor = 'Gryffindor';
  static const ravenclaw = 'Ravenclaw';
  static const hufflepuff = 'Hufflepuff';
  static const slytherin = 'Slytherin';
}

class ScreenName {
  static const home = '/home';
  static const result = '/result';
  static const question = '/question';
}

// text 
/*
  Gryffindor:
"Courage, bravery, nerve, and chivalry."
(Dũng cảm, can đảm, dũng khí và lòng nghĩa hiệp.)

Hufflepuff:
"Hard work, patience, justice, and loyalty."
(Chăm chỉ, kiên nhẫn, công bằng và trung thành.)

Ravenclaw:
"Wisdom, wit, and learning."
(Sự khôn ngoan, trí tuệ và học thức.)

Slytherin:
"Ambition, cunning, leadership, and resourcefulness."
(Tham vọng, xảo quyệt, khả năng lãnh đạo và sự khéo léo.)


 */
