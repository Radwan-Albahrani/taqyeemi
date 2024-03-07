import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'quiz_data_model.freezed.dart';
part 'quiz_data_model.g.dart';

@freezed
class QuizData with _$QuizData {
  factory QuizData({
    required String prompt,
    required int numberOfQuestions,
  }) = _QuizData;

  factory QuizData.fromJson(Map<String, dynamic> json) =>
      _$QuizDataFromJson(json);
}
