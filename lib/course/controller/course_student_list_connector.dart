import 'package:administracao/course/course_student_list_page.dart';
import 'package:flutter/material.dart';

class CourseStudentListConnector extends StatelessWidget {
  final String courseId;
  const CourseStudentListConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CourseStudentListPage();
  }
}
