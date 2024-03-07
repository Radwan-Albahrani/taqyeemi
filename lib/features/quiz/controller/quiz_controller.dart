import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';
import 'package:taqyeemi/core/models/quiz_data_model.dart';
// ignore: unused_import
import '../repository/quiz_repository.dart';

final quizControllerProvider = StateNotifierProvider<QuizController, bool>(
    (ref) => QuizController(
        quizRepository: ref.watch(quizRepositoryProvider), ref: ref));

final getQuizByOpenAiProvider =
    FutureProvider.family<List<Question>, QuizData>((ref, data) {
  // final data = {
  //   "prompt": "Flutter is open source platform for mobile application development.",
  //   "numberOfQuestions": 1
  // };
  final quizController = ref.watch(quizControllerProvider.notifier);
  final questions = quizController.getQuizByOpenAI(
      prompt: data.prompt, numberOfQuestions: data.numberOfQuestions);
  return questions;
});

class QuizController extends StateNotifier<bool> {
  final QuizRepository _quizRepository;
  QuizController({required QuizRepository quizRepository, required Ref ref})
      : _quizRepository = quizRepository,
        super(false);

  Future<List<Question>> getQuizByOpenAI(
      {required String prompt, required int numberOfQuestions}) async {
    final questions = await _quizRepository.getQuizByOpenAI(
        prompt: prompt, numberOfQuestions: numberOfQuestions);
    return questions;
  }
}
