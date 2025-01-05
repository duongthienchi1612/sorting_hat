import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:sorting_hat/business/master_data_business.dart';
import 'package:sorting_hat/dependencies.dart';
import 'package:sorting_hat/model/preference/user_reference.dart';
import 'package:sorting_hat/model/question_model.dart';
import 'package:sorting_hat/model/repository/master_data/answer_entity.dart';
import 'package:sorting_hat/model/repository/master_data/question_entity.dart';
import 'package:sorting_hat/repository/interface/question_repository.dart';

part 'question_event.dart';
part 'question_state.dart';

enum Houses { gry, rav, huf, sly }

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

  void _onLoadData(LoadData event, Emitter<QuestionState> emit) async {
    gryPoint = await userRef.getGryPoint() ?? 0;
    ravPoint = await userRef.getRavPoint() ?? 0;
    hufPoint = await userRef.getHufPoint() ?? 0;
    slyPoint = await userRef.getSlyPoint() ?? 0;
    mQuestions = masterData.questions!;
    mAnswers = masterData.answers!;

    final answers = mAnswers.where((e) => e.questionId == mQuestions[1].id).toList();
    final data = QuestionModel(currentQuestionId: 1, question: mQuestions, answers: answers);
    emit(QuestionLoaded(data: data));
  }

  void _onSelectAnswer(SelectAnswer event, Emitter<QuestionState> emit) async {
    gryPoint += event.gryPoint;
    ravPoint += event.ravPoint;
    hufPoint += event.hufPoint;
    slyPoint += event.slyPoint;

    //save lai vao share reference
    await userRef.setGryPoint(gryPoint);
    await userRef.setRavPoint(ravPoint);
    await userRef.setHufPoint(hufPoint);
    await userRef.setSlyPoint(slyPoint);

    if (event.lastQuestionCode + 1 < mQuestions.length) {
      final answers = mAnswers.where((e) => e.questionId == mQuestions[event.lastQuestionCode + 1].id).toList();
      final data = QuestionModel(currentQuestionId: event.lastQuestionCode + 1, question: mQuestions, answers: answers);
      emit(QuestionLoaded(data: data));
    } else {
      double maxValue = gryPoint;
      Houses yourHouse = Houses.gry;
      if (ravPoint > maxValue) {
        maxValue = ravPoint;
        yourHouse = Houses.rav;
      }
      if (hufPoint > maxValue) {
        maxValue = hufPoint;
        yourHouse = Houses.huf;
      }
      if (slyPoint > maxValue) {
        maxValue = slyPoint;
        yourHouse = Houses.sly;
      }

      emit(QuestionLoaded(result: yourHouse));
    }
  }
}
