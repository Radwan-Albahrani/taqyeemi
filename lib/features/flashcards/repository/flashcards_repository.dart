import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taqyeemi/core/core.dart';
import 'package:taqyeemi/core/providers/firebase_providers.dart';
import 'package:taqyeemi/models/flashcard_model.dart';
import 'package:taqyeemi/models/lecture_model.dart';

final flashCardsRepositoryProvider = Provider<FlashCardsRepository>((ref) {
  return FlashCardsRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class FlashCardsRepository {
  final FirebaseFirestore _firestore;
  FlashCardsRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _flashCards =>
      _firestore.collection(FirebaseConstants.lecturesCollection);

  FutureVoid uploadLecture(LectureModel lecture) async {
    try {
      return right(await _flashCards.doc(lecture.id).set(lecture.toMap()));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid addFlashCard({required String lectureId ,required List<FlashCard> flashCards}) async {
    try {
      return right(await _flashCards.doc(lectureId).update({
        'flashCards': FieldValue.arrayUnion(flashCards.map((e) => e.toMap()).toList())
      }));
    } on FirebaseException catch (e) {
      return Left(Failure(e.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
