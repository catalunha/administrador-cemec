import 'package:flutter/material.dart';

class CourseStudentListPage extends StatelessWidget {
  const CourseStudentListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudantes deste curso'),
      ),
    );
  }
}
