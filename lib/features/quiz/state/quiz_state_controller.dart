import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';
import 'quiz_state.dart';

final quizStateControllerProvider =
    StateNotifierProvider.autoDispose<QuizStateController, QuizState>(
  (ref) => QuizStateController(),
);

final questionsProvider2 = StateProvider<List<Question>?>((ref) {
  return null;
});

class QuizStateController extends StateNotifier<QuizState> {
  QuizStateController() : super(QuizState.initial());

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.answer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.correct..add(currentQuestion),
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        incorrect: state.incorrect..add(currentQuestion),
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions) {
    state = state.copyWith(
      selectedAnswer: '',
      status: state.questionNumber < questions.length
          ? QuizStatus.initial
          : QuizStatus.complete,
      questionNumber: state.questionNumber + 1,
    );
    state.pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.ease,
    );
  }

  void startQuiz(List<Question> questions) {
    state = state.copyWith(
      questions: questions,
      status: QuizStatus.initial,
    );
  }

  void isNewQuiz(bool status) {
    state = state.copyWith(
      isNew: status,
    );
  }

  void completeQuiz() {
    state = state.copyWith(status: QuizStatus.complete);
  }

  bool isQuizStarted() {
    return state.questions.isNotEmpty && state.status != QuizStatus.complete;
  }

  void reset() {
    state = QuizState.initial();
  }

  void saveQuiz() {
    state = state.copyWith(isSaved: true);
  }
}
