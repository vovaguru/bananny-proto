import 'dart:math';

import 'package:flutter/material.dart';

class MathQuizScreen extends StatefulWidget {
  const MathQuizScreen({super.key});

  @override
  State<MathQuizScreen> createState() => _MathQuizScreenState();
}

class _MathQuizScreenState extends State<MathQuizScreen> {
  late int num1;
  late int num2;
  late int answer;
  late int userAnswer;
  late bool isCorrect;
  late List<int> possibleAnswers;

  void _generateNumbers() {
    final random = Random();
    num1 = random.nextInt(20);
    num2 = random.nextInt(20);
    answer = num1 + num2;
    possibleAnswers = [
      answer,
      random.nextInt(40),
      random.nextInt(40),
      random.nextInt(40),
    ]..shuffle();
    userAnswer = 0;
    isCorrect = false;
  }

  void _checkAnswer(int selectedAnswer) {
    setState(() {
      isCorrect = selectedAnswer == answer;
      if (isCorrect) _generateNumbers();
    });
  }

  @override
  void initState() {
    super.initState();
    _generateNumbers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Математика'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$num1 + $num2 = ?',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            _buildAnswerButton(possibleAnswers[0]),
            _buildAnswerButton(possibleAnswers[1]),
            _buildAnswerButton(possibleAnswers[2]),
            _buildAnswerButton(possibleAnswers[3]),
            const SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       _generateNumbers();
            //     });
            //   },
            //   child: const Text('Следующий вопрос'),
            // ),
            const SizedBox(height: 16.0),
            isCorrect ? const Text('Правильно!') : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(int answer) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: () {
          _checkAnswer(answer);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(answer.toString(), style: const TextStyle(fontSize: 26)),
        ),
      ),
    );
  }
}
