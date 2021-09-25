import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_question_app/models/question_model.dart';
import 'package:quiz_question_app/screens/result_screen/result_screen.dart';
import 'package:quiz_question_app/screens/welcome_screen.dart';

class QuizController extends GetxController with SingleGetTickerProviderMixin {
  String name = '';

  //question variables
  int get countOfQuestion => _questionsList.length;
  final List<QuestionModel> _questionsList = [
    QuestionModel(
      id: 1,
      question:
          "Flutter is an open-source UI software development kit created by ______",
      answer: 1,
      options: ['Apple', 'Google', 'Facebook', 'Microsoft'],
    ),
    QuestionModel(
      id: 2,
      question: "When google release Flutter.",
      answer: 2,
      options: ['Jun 2017', 'Jun 2017', 'May 2017', 'May 2018'],
    ),
    QuestionModel(
      id: 3,
      question: "A memory location that holds a single letter or number.",
      answer: 2,
      options: ['Double', 'Int', 'Char', 'Word'],
    ),
    QuestionModel(
      id: 4,
      question: "What command do you use to output data to the screen?",
      answer: 2,
      options: ['Cin', 'Count>>', 'Cout', 'Output>>'],
    ),
  ];
  List<QuestionModel> get questionsList => [..._questionsList];
  bool _isPressed = false;
  bool get isPressed => _isPressed;
  double _numberOfQuestion = 1;
  double get numberOfQuestion => _numberOfQuestion;
  int? _selectAnswer;
  int? get selectAnswer => _selectAnswer;
  int? _correctAnswer;
  // int? get correctAnswer => _correctAnswer;
  int _countOfCorrectAnswers = 0;
  int get countOfCorrectAnswers => _countOfCorrectAnswers;

  double get scoreResult {
    return _countOfCorrectAnswers * 100 / _questionsList.length;
  }

  final Map<int, bool> _questionIsAnswerd = {};
  var isFirstAnswer = true;
  //controller
  late PageController pageController;
  //timer
  Timer? _timer;
  final maxSec = 15;
  final RxInt _sec = 15.obs;
  RxInt get sec => _sec;

  void checkAnswer(QuestionModel questionModel, int selectAnswer) {
    _isPressed = true;

    _selectAnswer = selectAnswer;
    _correctAnswer = questionModel.answer;

    if (_correctAnswer == _selectAnswer) {
      _countOfCorrectAnswers++;
    }
    stopTimer();
    _questionIsAnswerd.update(questionModel.id, (value) => true);
    Future.delayed(const Duration(seconds: 3)).then((value) => nextQuestion());
    update();
  }

  bool checkIsQuestAnswer(int quesId) {
    return _questionIsAnswerd.entries
        .firstWhere((element) => element.key == quesId)
        .value;
  }

  Color getColor(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Colors.green.shade700;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Colors.red.shade700;
      }
    }
    return Colors.white;
  }

  IconData getIcon(int answerIndex) {
    if (_isPressed) {
      if (answerIndex == _correctAnswer) {
        return Icons.done;
      } else if (answerIndex == _selectAnswer &&
          _correctAnswer != _selectAnswer) {
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void startTimer() {
    resetTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sec.value > 0) {
        _sec.value--;
      } else {
        stopTimer();
        nextQuestion();
      }
    });
  }

  void resetTimer() => _sec.value = maxSec;

  void stopTimer() => _timer!.cancel();

  void nextQuestion() {
    if (_timer != null || _timer!.isActive) {
      stopTimer();
    }

    if (pageController.page == _questionsList.length - 1) {
      Get.offAndToNamed(ResultScreen.routeName);
    } else {
      _isPressed = false;
      pageController.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.linear);

      startTimer();
    }
    _numberOfQuestion = pageController.page! + 2;
    update();
  }

  void startAgain() {
    _correctAnswer = null;
    _countOfCorrectAnswers = 0;
    resetAnswer();
    _selectAnswer = null;
    Get.offAllNamed(WelcomeScreen.routeName);
  }

  void resetAnswer() {
    for (var element in _questionsList) {
      _questionIsAnswerd.addAll({element.id: false});
    }
    update();
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    resetAnswer();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
