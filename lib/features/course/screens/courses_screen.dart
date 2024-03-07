import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taqyeemi/core/services/openai_services.dart';
import 'package:taqyeemi/features/course/controller/course_controller.dart';
import 'package:taqyeemi/features/course/screens/widgets/course_information.dart';

import '../../../core/core.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(openAIServicesProvider).generateFlashCards(
      text: """Drawbacks of One-Time Reads
        Now, what can you do if your weather-enthusiast users want their updates continuously? Here are two options:

        Pull-to-Refresh: Add a RefreshIndicator widget that lets users tug down on their screen to demand the latest forecast. Each pull is like asking the server, "How about now? And now?" Users get up-to-date data, along with that satisfying buzz of fresh information.
        Polling: Set a timer within your app that automatically and routinely asks the server for updates. This doesn’t require any effort from your users. The app UI will quietly keep itself current, giving them the latest weather without lifting a finger.
        Both pull-to-refresh and polling solve the immediate issue, but they’re far from perfect and come with their own headaches:

        Overfetching: When the app checks in with the server more often than necessary—imagine your app eagerly asking for updates every minute, while the server only refreshes the forecast every half hour. You’re fetching data that hasn’t changed, wasting bandwidth and resources.
        Stale data: When the app doesn’t check in often enough. If it’s only asking for updates every hour, yet the server refreshes every five minutes, your users might miss out on important weather shifts.
        At the core of the problem is this: the server is the source of truth, and the app is left guessing the right rhythm for asking questions.

        Bottom line: if we want to get the latest data as soon as it changes, one-time reads fall short, and we should consider realtime updates instead."""
            );
    return Center(
      child: Column(
        children: [
          ref.watch(coursesProvider).when(
                data: (courses) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return CourseInformation(
                          course: courses[index],
                        );
                      },
                    ),
                  );
                },
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader(),
              )
        ],
      ),
    );
  }
}
