import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_question_app/constants.dart';
import 'package:quiz_question_app/controllers/quiz_controller.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: Get.find<QuizController>(),
      builder: (controller) => Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(),
        ),
        child: Stack(
          children: [
            // LayoutBuilder provide us the available space for the conatiner
            // constraints.maxWidth needed for our animation
            LayoutBuilder(
              builder: (context, constraints) => Container(
               // width: constraints.maxWidth * controller.animation.value,
                decoration: BoxDecoration(
                  color: KPrimaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            Positioned.fill(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 // Text('${(controller.animation.value * 60).round()} Sec'),
                //  const Icon(Icons.timer, color: Colors.white),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
