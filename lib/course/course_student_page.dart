import 'package:administracao/coordinator/controller/coordinator_tile.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/course_tile.dart';
import 'package:administracao/student/controller/student_all_connector.dart';
import 'package:administracao/student/controller/student_card_connector.dart';
import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class CourseStudentPage extends StatelessWidget {
  final List<UserModel> studentListOfCourse;
  final UserModel coordinator;
  final CourseModel courseModel;

  const CourseStudentPage({
    Key? key,
    required this.coordinator,
    required this.courseModel,
    required this.studentListOfCourse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudantes deste curso'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: CourseTile(
              courseModel: courseModel,
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 15, right: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: CoordinatorTile(
              coordinator: coordinator,
            ),
          ),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: studentListOfCourse
                    .map((e) => StudentCardConnector(user: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(AppIconData.addInCloud),
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StudentAllConnector(label: 'Selecione um estudante');
                });
          }),
    );
  }
}
