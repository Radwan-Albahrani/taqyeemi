import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';
import 'package:taqyeemi/core/providers/firebase_providers.dart';
import 'package:taqyeemi/core/services/openai_service.dart';

final quizRepositoryProvider = Provider(
    (ref) => QuizRepository(firestore: ref.read(firestoreProvider), ref: ref));

class QuizRepository {
  final Ref _ref;

  QuizRepository({required FirebaseFirestore firestore, required Ref ref})
      : _ref = ref;

  Future<List<Question>> getQuizByOpenAI(
      {required String prompt, required int numberOfQuestions}) async {
    final openai = _ref.read(openAiProvider);
    final questions = await openai.getQuestions(prompt, numberOfQuestions);
    return questions;
  }
}
