import 'package:administracao/student/student_tile.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class StudentAll extends StatelessWidget {
  final String label;
  final List<UserModel> userListAll;
  final Function(String) insertUserInCourse;
  const StudentAll({
    Key? key,
    required this.userListAll,
    required this.insertUserInCourse,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(label),
      children: [
        SingleChildScrollView(
          child: Column(
            children: userListAll
                .map(
                  (e) => InkWell(
                    onTap: () {
                      insertUserInCourse(e.id);
                      Navigator.pop(context);
                    },
                    child: StudentTile(user: e),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
