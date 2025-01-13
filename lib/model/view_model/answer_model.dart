class AnswerModel {
  int? id;
  int? questionId;
  String? answerText;
  double? gryPoint;
  double? ravPoint;
  double? hufPoint;
  double? slyPoint;
  String? imagePath;

  AnswerModel({
    this.id,
    this.questionId,
    this.answerText,
    this.gryPoint,
    this.ravPoint,
    this.hufPoint,
    this.slyPoint,
    this.imagePath,
  });
}
