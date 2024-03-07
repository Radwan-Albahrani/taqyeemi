// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/common/loader.dart';
import 'package:taqyeemi/core/models/quiz_data_model.dart';
import 'widgets/body.dart';
import '../state/quiz_state_controller.dart';

import '../controller/quiz_controller.dart';

class QuizingScreen extends ConsumerWidget {
  final String? quizID;
  final int? questionNumbers;
  final String? quizText;

  const QuizingScreen({
    super.key,
    this.quizID,
    this.questionNumbers,
    this.quizText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: TextButton(
            style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
            onPressed: () {
              ref.watch(quizStateControllerProvider.notifier).reset();
              Navigator.of(context).pop();
            },
            child: const Text(
              "Exit",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ref
          .watch(getQuizByOpenAiProvider(
              QuizData(prompt: quizText!, numberOfQuestions: questionNumbers!)))
          .when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text("No Questions Found, Try Again!"),
            );
          }
          return Body(questions: data);
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () {
          return const Center(child: Loader());
        },
      ),
    );
  }
}
