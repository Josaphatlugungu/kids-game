import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'New Game.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  late Random _random;

  final player = AudioPlayer();
  Future<void> _playThemeSound() async {
    player.setReleaseMode(ReleaseMode.loop);
    player.play(AssetSource('game_theme.mp3'),mode:PlayerMode.mediaPlayer );
  }

  @override
  void initState() {
    _random = Random();
    _timer = Timer.periodic(Duration(seconds: 20), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Color _getRandomColor() {
    return Colors.primaries[_random.nextInt(Colors.primaries.length)];
  }

  double _getLottieSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return 120.0;
    } else if (width < 900) {
      return 200.0;
    } else {
      return 300.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _getRandomColor();

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
              height: _getLottieSize(context),
          width: _getLottieSize(context),
          child: Lottie.network(
            'https://assets6.lottiefiles.com/packages/lf20_2oW79h.json',
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _playThemeSound();
            Get.to(() => GameScreen());
          },
          child: Text(
            'Start Game',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Marker Felt',
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey[700],
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement options screen
          },
          child: Text(
            'Options',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Marker Felt',
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.blueGrey[700],
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement instructions screen
          },
          child: Text(
            'Instructions',
            style: TextStyle{
          "fontSize": 24,
          "fontFamily": 'Marker Felt',
          },
            style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey[700],
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          ],
        ),
      ),
    ),
    );
  }
}