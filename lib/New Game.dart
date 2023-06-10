import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Assignment Screen.dart';
import 'Question.dart';
import 'QuestionProvider.dart';
import 'Assignment.dart';



class GameScreen extends StatelessWidget {
  final questionProvider = QuestionProvider(filename: 'questions.csv');
  final assignmentProvider = AssignmentProvider(filename: 'assignments.csv');

  final player = AudioPlayer();
  Future<void> _playPingSound() async {
    player.play(AssetSource('choose_card.mp3'), mode: PlayerMode.lowLatency);
    // Play a ping sound here
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 900;

    return Scaffold(
      body: isWideScreen
          ? _buildWideScreenLayout(context)
          : _buildNarrowScreenLayout(context),
    );
  }

  Widget _buildWideScreenLayout(BuildContext context) {
    return Row(
      children: [
        _buildGridTile(
          'Vraag',
          Icons.help,
          Colors.orange,
              () => _navigateToRandomQuestionScreen(context),
        ),
        _buildGridTile(
          'Opdracht',
          Icons.work,
          Colors.green,
              () => _navigateToRandomAssignmentScreen(context),
        ),
        _buildGridTile(
          'Durven',
          Icons.whatshot,
          Colors.red,
              () => _navigateToRandomQuestionScreen(context),
        ),
        _buildGridTile(
          'Verassing',
          Icons.card_giftcard,
          Colors.blue,
              () => _navigateToRandomQuestionScreen(context),
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout(BuildContext context) {
    return Column(
      children: [
        _buildGridTile(
          'Vraag',
          Icons.help,
          Colors.orange,
              () => _navigateToRandomQuestionScreen(context),
        ),
        _buildGridTile(
          'Opdracht',
          Icons.work,
          Colors.green,
              () => _navigateToRandomAssignmentScreen(context),
        ),
        _buildGridTile(
          'Durven',
          Icons.whatshot,
          Colors.red,
              () => _navigateToRandomQuestionScreen(context),
        ),
        _buildGridTile(
          'Verassing',
          Icons.card_giftcard,
          Colors.blue,
              () => _navigateToRandomQuestionScreen(context),
        ),
      ],
    );
  }

  Widget _buildGridTile(String title, IconData icon, Color color, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: color,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }




  void _navigateToRandomQuestionScreen(BuildContext context) async {
    final questions = await questionProvider.fetchQuestions();
    questions.shuffle(Random());
    Question q = questions[Random().nextInt(questions.length)];
    _playPingSound();
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            QuestionScreen(question: q),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  void _navigateToRandomAssignmentScreen(BuildContext context) async {
    final assignments = await assignmentProvider.fetchAssignments();
    assignments.shuffle(Random());
    Assignment a = assignments[Random().nextInt(assignments.length)];
    _playPingSound();
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            AssignmentScreen(assignment: a),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

}
