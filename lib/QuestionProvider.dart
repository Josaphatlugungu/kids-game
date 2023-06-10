import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class QuestionProvider {
  final String filename;

  QuestionProvider({required this.filename});

  Future<List<Question>> fetchQuestions() async {
    final data = await rootBundle.loadString('lib/$filename');
    final csv = CsvToListConverter(fieldDelimiter: ';').convert(data); // set semicolon as the field delimiter
    final questions = csv
        .skip(1)
        .map((row) => Question.fromList(row))
        .toList();
    return questions;
  }
}

class Question {
  final String id;
  final String ageGroup;
  final String question;
  final String answer;
  final String theme;
  final List<String> options;

  Question({
    required this.id,
    required this.ageGroup,
    required this.question,
    required this.answer,
    required this.theme,
    required this.options,
  });

  factory Question.fromList(List<dynamic> row) {
    final options = row.sublist(5).cast<String>().where((option) => option.isNotEmpty).toList();
    return Question(
      id: row[0].toString(),
      ageGroup: row[1].toString(),
      question: row[2].toString(),
      answer: row[3].toString(),
      theme: row[4].toString(),
      options: options,
    );
  }
}

