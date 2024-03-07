import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:taqyeemi/core/models/question_model.dart';

final openAiProvider = Provider<OpenAIService>((ref) {
  return OpenAIService();
});

class OpenAIService {
  Future<List<Question>> getQuestions(
      String text, int numberOfQuestions) async {
    try {
      final String apiKey = dotenv.env["OPENAI_API_KEY"]!;
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content': """
              i want you to write me questions from text ill provide
              make questions from the text between the +text+ only and it should be meaningful and related to the text
              questions type: mcq (straight forward) (only one answer correct)
              questions number: $numberOfQuestions
              note: dont write anything else just questions and their answers pls and only one option should be correct!!!
              example: 
              According to Betty Friedan, what distinguishes human behavior from animal behavior or machine behavior?
              A) Cell phones
              B) Internet
              C) Transcending the present and having future purposes
              D) Social networking
              Answer: C

              Which online social networking site was founded in 1995 and had approximately 100 million member profiles by 2006?
              A) Facebook
              B) Myspace
              C) Twitter
              D) Instagram
              Answer: B
              here the text: +$text+
              please write the questions and answers in the same format as above and send it to me
              question -> mcq choices -> answer
              

              """,
            }
          ],
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];

        content = content.trim();

        List<String> lines = content.split("\n");
        List<Question> questions = [];
        String question = "";
        List<String> answers = [];
        String answer = "";

        for (int i = 0; i < lines.length; i++) {
          String line = lines[i];
          if (line.contains("Answer:")) {
            answer = line.split("Answer: ")[1];
            if (answer.trim() == "A") {
              answer = answers[0];
            } else if (answer.trim() == "B") {
              answer = answers[1];
            } else if (answer.trim() == "C") {
              answer = answers[2];
            } else if (answer.trim() == "D") {
              answer = answers[3];
            }
            print("$i $question $answers $answer");
            questions.add(
                Question(question: question, answers: answers, answer: answer));
            question = "";
            answers = [];
            answer = "";
          } else if (line.contains("A)") ||
              line.contains("B)") ||
              line.contains("C)") ||
              line.contains("D)")) {
            answers.add(line);
          } else {
            question += line;
          }
        }
        return questions;
      } else {
        throw Exception("error");
      }
    } catch (e) {
      return [];
    }
  }
}
