import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';
import '../../state/quiz_state_controller.dart';

class Option extends ConsumerStatefulWidget {
  final String text;
  final int index;
  final VoidCallback press;
  final bool isCorrect;
  final Question question;

  const Option({
    super.key,
    required this.text,
    required this.index,
    required this.press,
    required this.isCorrect,
    required this.question,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OptionState();
}

class _OptionState extends ConsumerState<Option> {
  Color getTheRightColor() {
    if (ref.watch(quizStateControllerProvider).answered) {
      if (widget.isCorrect) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
    return Colors.white;
  }

  IconData getTheRightIcon() {
    return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getTheRightColor() != Colors.white
          ? null
          : () {
              ref
                  .read(quizStateControllerProvider.notifier)
                  .submitAnswer(widget.question, widget.text);
              widget.press();
            },
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(color: getTheRightColor()),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                widget.text,
                style: TextStyle(color: getTheRightColor(), fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                color: getTheRightColor() == Colors.white
                    ? Colors.transparent
                    : getTheRightColor(),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: getTheRightColor()),
              ),
              child: getTheRightColor() == Colors.white
                  ? null
                  : Icon(getTheRightIcon(), size: 16),
            )
          ],
        ),
      ),
    );
  }
}
