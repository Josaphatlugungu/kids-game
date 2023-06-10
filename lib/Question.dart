import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'QuestionProvider.dart';

class QuestionScreen extends StatefulWidget {
  final Question question;

  QuestionScreen({required this.question});

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Timer _timer;
  int _remainingSeconds = 60;
  bool _showAnswer = false;
  bool _showRest = false;
  final String animationUrl =
      'https://assets1.lottiefiles.com/packages/lf20_y2tcu7p4.json';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _showAnswer = true;
        }
      });
    });
  }

  void _showAnswerScreen() {
    setState(() {
      _showAnswer = true;
      _timer.cancel();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.network(
              animationUrl,
              fit: BoxFit.cover,
              onLoaded: (composition) {
                Future.delayed(
                  Duration(milliseconds: composition.duration.inMilliseconds),
                      () {
                    setState(() {
                      _showRest = true;
                    });
                  },
                );
              },
              reverse: true,
            ),
          ),
          if (_showRest)
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.question.theme,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Age group: ${widget.question.ageGroup}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      widget.question.question,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(height: 40),
                    if (_showAnswer)
                      Text(
                        widget.question.answer,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    SizedBox(height: 20),
                    Flexible(
                      child: _showAnswer
                          ? ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('End Turn'),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$_remainingSeconds',
                            style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: _showAnswerScreen,
                            child: Text('Show Answer'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }




}