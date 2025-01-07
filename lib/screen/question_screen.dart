import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/question/question_bloc.dart';
import '../constants.dart';
import '../dependencies.dart';

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
                                    image:
                                        DecorationImage(image: AssetImage('assets/images/${e.imagePath!}'), fit: BoxFit.cover)),
                                alignment: Alignment.center,
                                child: Text(
                                  e.answerTextVi!,
                                  style: const TextStyle(
                                    fontSize: 36,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/background_question.png'), fit: BoxFit.cover),
                  ),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.data!.currentQuestionId.toString()} / ${state.data!.question.length}',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        question.questionTextVi!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBE4C5),
                          shadows: const [
                            Shadow(
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(vertical: 12),
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBE4C5),
                                    border: Border.all(color: const Color(0xFF6E4B3A), width: 2),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.4),
                                        offset: const Offset(2, 4),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    e.answerTextVi!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              }
              return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/background_result.png'), fit: BoxFit.cover),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 40),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/home')),
                          icon: Icon(
                            Icons.home,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Spacer(),
                      Image.asset(state.imagePath!),
                      Spacer(),
                      Text(
                        'Your house is \n ${state.houseName}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBE4C5),
                        ),
                      ),
                      Spacer(),
                    ],
                  ));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
