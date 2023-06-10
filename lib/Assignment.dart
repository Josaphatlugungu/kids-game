import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class AssignmentProvider {
  final String filename;

  AssignmentProvider({required this.filename});

  Future<List<Assignment>> fetchAssignments() async {
    final data = await rootBundle.loadString('lib/$filename');
    final csv = CsvToListConverter(fieldDelimiter: ';').convert(data); // set semicolon as the field delimiter
    final assignments =
    csv.skip(1).map((row) => Assignment.fromList(row)).toList();
    return assignments;
  }
}

class Assignment {
  final String id;
  final String ageGroup;
  final String assignment;
  final String theme;

  Assignment({
    required this.id,
    required this.ageGroup,
    required this.assignment,
    required this.theme,
  });

  factory Assignment.fromList(List<dynamic> row) {
    return Assignment(
      id: row[0].toString(),
      ageGroup: row[1].toString(),
      assignment: row[2].toString(),
      theme: row[3].toString(),
    );
  }
}
