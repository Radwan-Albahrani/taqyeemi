import 'dart:io';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/extensions/string_case_extension.dart';
import 'package:taqyeemi/core/utils/get_pdftext.dart';
import 'package:taqyeemi/core/utils/pick_file.dart';
import 'package:taqyeemi/core/utils/show_toast.dart';
import 'package:taqyeemi/features/quiz/screens/quizing_screen.dart';

import '../state/quiz_state_controller.dart';

class GenerateQuizScreen extends ConsumerStatefulWidget {
  const GenerateQuizScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GenerateQuizScreenState();
}

class _GenerateQuizScreenState extends ConsumerState<GenerateQuizScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _numberOfQuestionsController =
      TextEditingController();

  File? pdfFile;
  Uint8List? webPdfFile;
  String? pdfText;
  int value = 0;

  void selectFile() async {
    final res = await pickFile();
    if (res != null) {
      if (kIsWeb) {
        webPdfFile = res.files.first.bytes;
        File file = File.fromRawPath(webPdfFile!);
        print(file);
        loadpdf(file);
      } else {
        pdfFile = File(res.files.single.path!);
        loadpdf(pdfFile);
      }
    }
  }

  void loadpdf(File? pdfFile) async {
    if (pdfFile != null) {
      final text = await getPDFtext(pdfFile.path);
      if (text == 'Failed to get PDF text.') {
        if (mounted) {
          showToast(
            context: context,
            message: "Failed to get PDF text.",
            type: ToastType.error,
          );
        }
      }
      setState(() {
        pdfText = text;
        _textController.text = text;
        checkLength();
      });
    }
  }

  void checkLength() {
    if (_textController.text.length > 3000) {
      _textController.text = _textController.text.substring(0, 3000);
    }
  }

  bool isQuizPlaying(WidgetRef ref, BuildContext context) {
    final quizController = ref.watch(quizStateControllerProvider.notifier);
    return quizController.isQuizStarted();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text('are you ready to generate your quiz?'.toTitleCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    AnimatedToggleSwitch<int>.rolling(
                      current: value,
                      values: const [0, 1],
                      onChanged: (i) {
                        setState(() {
                          value = i;
                        });
                      },
                      colorBuilder: (
                        value,
                      ) {
                        switch (value) {
                          case 0:
                            return Colors.black;
                          case 1:
                            return Colors.black;
                          default:
                            return Colors.black;
                        }
                      },
                      borderColor: Colors.black,
                      iconBuilder: (value, size, active) {
                        switch (value) {
                          case 0:
                            return const Icon(Icons.edit_outlined,
                                color: Colors.white);
                          case 1:
                            return const Icon(Icons.file_copy_outlined,
                                color: Colors.white);
                          default:
                            return const Icon(Icons.close, color: Colors.white);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    value == 1
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(0),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () {
                                  selectFile();
                                },
                                child: Text(
                                  pdfFile != null
                                      ? pdfFile!.path.split('/').last
                                      : "Select File",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                cursorColor: Colors.black,
                                scrollPadding:
                                    const EdgeInsets.only(bottom: 100),
                                maxLines: 15,
                                controller: _textController,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  hintText: "Enter your text here",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          cursorColor: Colors.black,
                          scrollPadding: const EdgeInsets.only(bottom: 100),
                          keyboardType: TextInputType.number,
                          controller: _numberOfQuestionsController,
                          decoration: InputDecoration(
                            hintText: "Enter number of questions",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(0),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            if (isQuizPlaying(ref, context)) {
                              showToast(
                                context: context,
                                message: "Please finish your quiz first",
                                type: ToastType.error,
                              );
                              return;
                            }

                            if (_numberOfQuestionsController.text.isNotEmpty &&
                                (int.parse(_numberOfQuestionsController.text) >
                                        10 ||
                                    int.parse(_numberOfQuestionsController
                                            .text) <=
                                        0)) {
                              showToast(
                                context: context,
                                message:
                                    "Please enter number of questions between 1-10",
                                type: ToastType.error,
                              );
                              return;
                            }

                            if (!_textController.text.isNotEmpty &&
                                !_numberOfQuestionsController.text.isNotEmpty) {
                              showToast(
                                context: context,
                                message: "Please fill all fields",
                                type: ToastType.error,
                              );
                            } else {
                              final quizStateController = ref
                                  .read(quizStateControllerProvider.notifier);
                              quizStateController.reset();
                              quizStateController.isNewQuiz(true);

                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return QuizingScreen(
                                  questionNumbers: int.parse(
                                      _numberOfQuestionsController.text.trim()),
                                  quizText: _textController.text.trim(),
                                );
                              }));
                            }
                          },
                          child: const Text(
                            "Generate Quiz",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
