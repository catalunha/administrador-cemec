import 'package:administracao/teacher/teacher_tile.dart';
import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class CourseTeacherCard extends StatelessWidget {
  final UserModel teacher;
  final Function(String, bool) updateTeacherInCollegiate;

  const CourseTeacherCard({
    Key? key,
    required this.teacher,
    required this.updateTeacherInCollegiate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        TeacherTile(teacher: teacher),
        Wrap(
          children: [
            IconButton(
              icon: Icon(AppIconData.delete),
              onPressed: () {
                updateTeacherInCollegiate(teacher.id, false);
              },
            ),
          ],
        )
      ],
    ));
  }
}
