import 'package:administracao/student/student_tile.dart';
import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final UserModel user;
  final Function(String) removeStudentOfCourse;

  const StudentCard({
    Key? key,
    required this.user,
    required this.removeStudentOfCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        StudentTile(user: user),
        Wrap(
          children: [
            IconButton(
              tooltip: 'Deletar este aluno do curso',
              icon: Icon(AppIconData.delete),
              onPressed: () {
                removeStudentOfCourse(user.id);
              },
            ),
            IconButton(
              tooltip: 'Modulos deste estudante',
              icon: Icon(AppIconData.module),
              onPressed: () async {
                Navigator.pushNamed(context, '/module_student',
                    arguments: user.id);
              },
            ),
          ],
        )
      ],
    ));
  }
}
