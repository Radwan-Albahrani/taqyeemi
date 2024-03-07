// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QuizData _$QuizDataFromJson(Map<String, dynamic> json) {
  return _QuizData.fromJson(json);
}

/// @nodoc
mixin _$QuizData {
  String get prompt => throw _privateConstructorUsedError;
  int get numberOfQuestions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuizDataCopyWith<QuizData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizDataCopyWith<$Res> {
  factory $QuizDataCopyWith(QuizData value, $Res Function(QuizData) then) =
      _$QuizDataCopyWithImpl<$Res, QuizData>;
  @useResult
  $Res call({String prompt, int numberOfQuestions});
}

/// @nodoc
class _$QuizDataCopyWithImpl<$Res, $Val extends QuizData>
    implements $QuizDataCopyWith<$Res> {
  _$QuizDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? numberOfQuestions = null,
  }) {
    return _then(_value.copyWith(
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfQuestions: null == numberOfQuestions
          ? _value.numberOfQuestions
          : numberOfQuestions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuizDataCopyWith<$Res> implements $QuizDataCopyWith<$Res> {
  factory _$$_QuizDataCopyWith(
          _$_QuizData value, $Res Function(_$_QuizData) then) =
      __$$_QuizDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String prompt, int numberOfQuestions});
}

/// @nodoc
class __$$_QuizDataCopyWithImpl<$Res>
    extends _$QuizDataCopyWithImpl<$Res, _$_QuizData>
    implements _$$_QuizDataCopyWith<$Res> {
  __$$_QuizDataCopyWithImpl(
      _$_QuizData _value, $Res Function(_$_QuizData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? prompt = null,
    Object? numberOfQuestions = null,
  }) {
    return _then(_$_QuizData(
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfQuestions: null == numberOfQuestions
          ? _value.numberOfQuestions
          : numberOfQuestions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QuizData with DiagnosticableTreeMixin implements _QuizData {
  _$_QuizData({required this.prompt, required this.numberOfQuestions});

  factory _$_QuizData.fromJson(Map<String, dynamic> json) =>
      _$$_QuizDataFromJson(json);

  @override
  final String prompt;
  @override
  final int numberOfQuestions;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'QuizData(prompt: $prompt, numberOfQuestions: $numberOfQuestions)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'QuizData'))
      ..add(DiagnosticsProperty('prompt', prompt))
      ..add(DiagnosticsProperty('numberOfQuestions', numberOfQuestions));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuizData &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.numberOfQuestions, numberOfQuestions) ||
                other.numberOfQuestions == numberOfQuestions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, prompt, numberOfQuestions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuizDataCopyWith<_$_QuizData> get copyWith =>
      __$$_QuizDataCopyWithImpl<_$_QuizData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QuizDataToJson(
      this,
    );
  }
}

abstract class _QuizData implements QuizData {
  factory _QuizData(
      {required final String prompt,
      required final int numberOfQuestions}) = _$_QuizData;

  factory _QuizData.fromJson(Map<String, dynamic> json) = _$_QuizData.fromJson;

  @override
  String get prompt;
  @override
  int get numberOfQuestions;
  @override
  @JsonKey(ignore: true)
  _$$_QuizDataCopyWith<_$_QuizData> get copyWith =>
      throw _privateConstructorUsedError;
}
