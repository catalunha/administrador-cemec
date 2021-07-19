import 'package:administracao/course/course_model.dart';
import 'package:administracao/course/course_teacher_card_connector.dart';
import 'package:administracao/teacher/teacher_all_connector.dart';
import 'package:flutter/material.dart';

import 'package:administracao/coordinator/coordinator_tile.dart';
import 'package:administracao/course/course_tile.dart';
import 'package:administracao/user/user_model.dart';

class CourseCollegiatePage extends StatelessWidget {
  final List<UserModel> collegiate;
  final UserModel? coordinator;
  final CourseModel? courseModel;
  final VoidCallback getTeacher;

  const CourseCollegiatePage({
    Key? key,
    required this.collegiate,
    required this.coordinator,
    required this.courseModel,
    required this.getTeacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Colegiado do curso'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          courseModel != null
              ? Card(
                  elevation: 10,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: CourseTile(
                    courseModel: courseModel,
                  ),
                )
              : Container(),
          coordinator != null
              ? Card(
                  elevation: 10,
                  margin: EdgeInsets.only(left: 15, right: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: CoordinatorTile(
                    coordinator: coordinator,
                  ),
                )
              : Container(),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: collegiate
                    .map((e) => CourseTeacherCardConnector(teacher: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          getTeacher();
          await showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return TeacherAllConnector(
                  label: 'Selecione um professor',
                );
              });
        },
      ),
    );
  }
}
