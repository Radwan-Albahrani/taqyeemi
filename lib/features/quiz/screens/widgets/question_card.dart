import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';

import 'option.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final VoidCallback nextQuestion;

  const QuestionCard({
    Key? key,
    required this.nextQuestion,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard> {
  bool isAnswered = false;

  void checkAnswered() {
    //     setState(() {
    //       isAnswered = true;
    //     });

    Future.delayed(const Duration(seconds: 2), () {
      widget.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.question.question,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20.0 / 2),
            ...List.generate(
              widget.question.answers.length,
              (index) => Option(
                question: widget.question,
                index: index,
                text: widget.question.answers[index],
                press: checkAnswered,
                isCorrect:
                    widget.question.answer == widget.question.answers[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
