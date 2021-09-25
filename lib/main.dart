import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_question_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_question_app/screens/result_screen/result_screen.dart';
import 'package:quiz_question_app/screens/welcome_screen.dart';
import 'package:quiz_question_app/util/bindings_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BilndingsApp(),
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
              // headline3: TextStyle(color: Colors.white),
              // headline6: TextStyle(color: Colors.white),

              // subtitle1: TextStyle(color: Colors.white),
              )),
      home:  const WelcomeScreen(),
      getPages: [
         GetPage(name: WelcomeScreen.routeName, page: () => const WelcomeScreen()),
        GetPage(name: QuizScreen.routeName, page: () => const QuizScreen()),
        GetPage(name: ResultScreen.routeName, page: () => const ResultScreen()),
      ],
    );
  }
}
