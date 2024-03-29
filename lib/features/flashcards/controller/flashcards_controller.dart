import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/utils.dart';
import 'package:taqyeemi/features/flashcards/repository/flashcards_repository.dart';
import 'package:taqyeemi/models/flashcard_model.dart';
import 'package:taqyeemi/models/lecture_model.dart';
import 'package:uuid/uuid.dart';

final flashCardsControllerProvider =
    StateNotifierProvider<FlashCardsController, bool>((ref) {
  return FlashCardsController(
    flashCardsRepository: ref.watch(flashCardsRepositoryProvider),
    ref: ref,
  );
});

class FlashCardsController extends StateNotifier<bool> {
  final FlashCardsRepository _flashCardsRepository;
  final Ref _ref;
  FlashCardsController(
      {required FlashCardsRepository flashCardsRepository, required Ref ref})
      : _flashCardsRepository = flashCardsRepository,
        _ref = ref,
        super(false);

  void addFlashCard(
      {required String lectureId,
      required List<FlashCard> flashCards,
      required BuildContext context}) async {
    state = true;
    final result = await _flashCardsRepository.addFlashCard(
        lectureId: lectureId, flashCards: flashCards);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {});
  }

  void uploadLecture(
      {required String title, required BuildContext context}) async {
    state = true;
    final LectureModel lecture = LectureModel(
      title: title,
      id: const Uuid().v4(),
      flashCards: [],
    );
    final result = await _flashCardsRepository.uploadLecture(lecture);
    state = false;
    result.fold((l) => showSnackBar(context, l.message), (r) {});
  }
}
