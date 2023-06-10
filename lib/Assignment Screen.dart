import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'Assignment.dart';

class AssignmentScreen extends StatefulWidget {
  final Assignment assignment;

  AssignmentScreen({required this.assignment});

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  late Timer _timer;
  int _remainingSeconds = 60;


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
          _timer.cancel();
          _playPingSound();
        }
      });
    });
  }


  final player = AudioPlayer();
  Future<void> _playPingSound() async {


    player.play(AssetSource('end_sound_timer.mp3'),mode:PlayerMode.lowLatency );

    // Play a ping sound here
  }

  void _finish() {
    _playPingSound();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Lottie.network(
            'https://assets1.lottiefiles.com/packages/lf20_wkzyqoeg.json',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.assignment.theme,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Age group: ${widget.assignment.ageGroup}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.assignment.assignment,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          '$_remainingSeconds',
                          style: TextStyle(
                            fontSize: 48,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _finish,
                          child: Text('Finish'),
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
