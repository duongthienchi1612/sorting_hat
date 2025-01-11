import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business/master_data_business.dart';
import '../../constants.dart';
import '../../dependencies.dart';
import '../../model/preference/user_reference.dart';
import '../../model/question_model.dart';
import '../../model/repository/master_data/answer_entity.dart';
import '../../model/repository/master_data/question_entity.dart';
import '../../repository/interface/question_repository.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final masterData = injector.get<MasterDataBusiness>();
  final answerRepository = injector.get<IQuestionRepository>();
  final userRef = injector.get<UserReference>();

  double gryPoint = 0;
  double ravPoint = 0;
  double hufPoint = 0;
  double slyPoint = 0;

  late List<QuestionEntity> mQuestions;
  late List<AnswerEntity> mAnswers;

  QuestionBloc() : super(QuestionInitial()) {
    on<LoadData>(_onLoadData);
    on<SelectAnswer>(_onSelectAnswer);
  }

  Future<void> _onLoadData(LoadData event, Emitter<QuestionState> emit) async {
    final currentQuestionId = await userRef.getCurrentQuestion() ?? 1;
    mQuestions = masterData.questions!;
    mAnswers = masterData.answers!;
    late List<AnswerEntity> answers;
    late QuestionEntity question;
    if (currentQuestionId > 1) {
      gryPoint = await userRef.getGryPoint() ?? 0;
      ravPoint = await userRef.getRavPoint() ?? 0;
      hufPoint = await userRef.getHufPoint() ?? 0;
      slyPoint = await userRef.getSlyPoint() ?? 0;
    } else {
      gryPoint = 0;
      ravPoint = 0;
      hufPoint = 0;
      slyPoint = 0;
    }
    question = mQuestions.firstWhereOrNull((e) => e.id == currentQuestionId)!;
    answers = mAnswers.where((e) => e.questionId == question.id).toList();
    final data = QuestionModel(
        currentQuestionId: currentQuestionId, question: question, answers: answers, totalQuestion: mQuestions.length);
    emit(QuestionLoaded(data: data));
  }

  Future<void> _onSelectAnswer(SelectAnswer event, Emitter<QuestionState> emit) async {
    gryPoint += event.gryPoint;
    ravPoint += event.ravPoint;
    hufPoint += event.hufPoint;
    slyPoint += event.slyPoint;

    //save lai vao share reference
    await userRef.setGryPoint(gryPoint);
    await userRef.setRavPoint(ravPoint);
    await userRef.setHufPoint(hufPoint);
    await userRef.setSlyPoint(slyPoint);
    await userRef.setCurrentQuestion(event.currentQuestionId + 1);

    if (event.currentQuestionId + 1 < mQuestions.length) {
      final question = mQuestions.firstWhereOrNull((e) => e.id == event.currentQuestionId + 1)!;
      final answers = mAnswers.where((e) => e.questionId == question.id).toList();
      final data = QuestionModel(
          currentQuestionId: event.currentQuestionId + 1, question: question, answers: answers, totalQuestion: mQuestions.length);
      emit(QuestionLoaded(data: data));
    } else {
      double maxValue = gryPoint;
      String yourHouse = HouseName.gryffindor;
      if (ravPoint > maxValue) {
        maxValue = ravPoint;
        yourHouse = HouseName.ravenclaw;
      }
      if (hufPoint > maxValue) {
        maxValue = hufPoint;
        yourHouse = HouseName.hufflepuff;
      }
      if (slyPoint > maxValue) {
        maxValue = slyPoint;
        yourHouse = HouseName.slytherin;
      }

      await userRef.setStatusQuiz(StatusQuiz.done);
      await userRef.setHouseResult(yourHouse);

      emit(QuestionLoaded(houseName: yourHouse));
    }
  }
}
