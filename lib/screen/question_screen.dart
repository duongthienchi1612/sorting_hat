import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sorting_hat/bloc/question/question_bloc.dart';
import 'package:sorting_hat/constants.dart';
import 'package:sorting_hat/dependencies.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final _bloc = injector.get<QuestionBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc..add(LoadData()),
      child: Scaffold(
        body: BlocBuilder<QuestionBloc, QuestionState>(
          builder: (context, state) {
            if (state is QuestionLoaded) {
              if (state.data != null) {
                final question = state.data!.question[state.data!.currentQuestionId];
                if (question.type == QuestionType.alternative) {
                  return Column(
                    children: [
                      ...state.data!.answers.map((e) => Expanded(
                            child: GestureDetector(
                              onTap: () => _bloc.add(
                                SelectAnswer(
                                    lastQuestionCode: state.data!.currentQuestionId,
                                    gryPoint: e.gryPoint!,
                                    ravPoint: e.ravPoint!,
                                    hufPoint: e.hufPoint!,
                                    slyPoint: e.slyPoint!),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/${e.imagePath!}'), fit: BoxFit.cover)
                                ),
                                alignment: Alignment.center,
                                child: Text(e.answerTextVi!, style: const TextStyle(fontSize: 36, color: Colors.white,),),
                              ),
                            ),
                          ))
                    ],
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                  child: Column(
                    children: [
                      Text(question.questionTextVi!),
                      const SizedBox(
                        height: 24,
                      ),
                      ...state.data!.answers.map(
                        (e) => GestureDetector(
                          onTap: () => _bloc.add(
                            SelectAnswer(
                                lastQuestionCode: state.data!.currentQuestionId,
                                gryPoint: e.gryPoint!,
                                ravPoint: e.ravPoint!,
                                hufPoint: e.hufPoint!,
                                slyPoint: e.slyPoint!),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            color: Colors.deepPurple,
                            child: Text(e.answerTextVi!),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Center(child: Text('result: ${state.result}'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
