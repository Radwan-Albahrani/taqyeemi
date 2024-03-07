import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/models/question_model.dart';
import 'package:taqyeemi/features/results/screens/results_page.dart';

import '../../state/quiz_state_controller.dart';

import 'question_card.dart';

class Body extends ConsumerStatefulWidget {
  final List<Question> questions;
  const Body({super.key, required this.questions});

  @override
  ConsumerState<Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<Body> {
  void nextQuestion(BuildContext context, WidgetRef ref) {
    if (mounted) {
      final quizController = ref.read(quizStateControllerProvider.notifier);

      // ignore: invalid_use_of_protected_member
      if (quizController.state.pageController.page!.toInt() ==
          widget.questions.length - 1) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const ResultScreen();
            },
          ),
        );
        return;
      }
      quizController.nextQuestion(widget.questions);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(quizStateControllerProvider.notifier)
          .startQuiz(widget.questions);
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizController = ref.watch(quizStateControllerProvider.notifier);

    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: ProgressBar(),
              // ),
              const SizedBox(height: 20.0),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text.rich(
                    TextSpan(
                      text:
                          "Question ${ref.watch(quizStateControllerProvider).questionNumber}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "/${widget.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )),
              const Divider(thickness: 1.5, color: Colors.white),

              Expanded(
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),

                  // ignore: invalid_use_of_protected_member
                  controller: quizController.state.pageController,
                  itemCount: widget.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                    nextQuestion: () => nextQuestion(context, ref),
                    question: widget.questions[index],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
