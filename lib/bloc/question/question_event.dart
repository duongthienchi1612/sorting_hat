part of 'question_bloc.dart';

@immutable
sealed class QuestionEvent {
  const QuestionEvent();
}

final class LoadData extends QuestionEvent {}

final class SelectAnswer extends QuestionEvent {
  final int lastQuestionCode;
  final double gryPoint;
  final double ravPoint;
  final double hufPoint;
  final double slyPoint;

  const SelectAnswer({
    required this.lastQuestionCode,
    required this.gryPoint,
    required this.ravPoint,
    required this.hufPoint,
    required this.slyPoint,
  });
}
