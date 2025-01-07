part of 'question_bloc.dart';

@immutable
sealed class QuestionState {}

final class QuestionInitial extends QuestionState {}

final class QuestionLoading extends QuestionState {}

final class QuestionLoaded extends QuestionState {
  final QuestionModel? data;
  final String? imagePath;
  final String? houseName;

  QuestionLoaded({this.data, this.imagePath, this.houseName});
}
