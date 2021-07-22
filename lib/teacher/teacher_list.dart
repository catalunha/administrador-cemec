import 'package:administracao/teacher/teacher_tile.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class TeacherList extends StatelessWidget {
  final String label;
  final List<UserModel> teacherList;
  final Function(String, bool) updateTeacherInCollegiate;
  const TeacherList({
    Key? key,
    required this.teacherList,
    required this.updateTeacherInCollegiate,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(label),
      children: [
        SingleChildScrollView(
          child: Column(
            children: teacherList
                .map((e) => InkWell(
                    onTap: () {
                      updateTeacherInCollegiate(e.id, true);
                      Navigator.pop(context);
                    },
                    child: TeacherTile(teacher: e)))
                .toList(),
          ),
        ),
      ],
    );
  }
}
