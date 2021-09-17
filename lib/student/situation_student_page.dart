import 'package:administracao/coordinator/controller/coordinator_tile.dart';
import 'package:administracao/student/student_tile.dart';
import 'package:administracao/teacher/teacher_tile.dart';
import 'package:flutter/material.dart';

import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/course_tile.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/situation/controller/situation_model.dart';
import 'package:administracao/situation/situation_card.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:administracao/user/controller/user_model.dart';

class SituationOfStudentPage extends StatelessWidget {
  final CourseModel? courseModel;
  final UserModel coordinator;
  final ModuleModel moduleModel;
  final UserModel? teacher;
  final UserModel student;

  final List<SituationModel> situationModelList;
  final List<String> studentSituationList;

  const SituationOfStudentPage({
    Key? key,
    this.courseModel,
    this.teacher,
    required this.moduleModel,
    required this.situationModelList,
    required this.coordinator,
    required this.student,
    required this.studentSituationList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Situações para este estudante'),
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
          Text(
            moduleModel.title,
            style: AppTextStyles.titleBoldHeading,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4, right: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 10,
              margin: EdgeInsets.only(left: 15, right: 15),
              child: TeacherTile(
                teacher: teacher,
              ),
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.only(left: 15, right: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: StudentTile(
              user: student,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildItens(context) {
    List<Widget> list = [];
    Map<String, SituationModel> map = Map.fromIterable(
      situationModelList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in moduleModel.situationOrder!) {
      if (map[index] != null) {
        bool temResource = studentSituationList.contains(map[index]!.id);

        list.add(Container(
            key: ValueKey(index),
            child: SituationCard(
              situationModel: map[index]!,
              color: temResource ? Colors.lime.shade900 : null,
            )));
      }
    }
    return list;
  }

  // void _onReorder(int oldIndex, int newIndex) {
  //   setState(() {
  //     if (newIndex > oldIndex) {
  //       newIndex -= 1;
  //     }
  //   });
  //   List<String> situationOrderTemp = widget.moduleModel.situationOrder!;
  //   String situationId = situationOrderTemp[oldIndex];
  //   situationOrderTemp.removeAt(oldIndex);
  //   situationOrderTemp.insert(newIndex, situationId);
  //   widget.onChangeSituationOrder(situationOrderTemp);
  // }
}
