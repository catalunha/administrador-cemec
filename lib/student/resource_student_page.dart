import 'package:administracao/coordinator/controller/coordinator_tile.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/course_tile.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/resource/resource_card.dart';
import 'package:administracao/resource/controller/resource_model.dart';
import 'package:administracao/student/student_tile.dart';
import 'package:administracao/teacher/teacher_tile.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class ResourceOfStudentPage extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel coordinator;

  final ModuleModel moduleModel;
  final UserModel? teacher;
  final UserModel student;

  final List<ResourceModel> resourceModelList;
  final List<String> studentResourceList;

  const ResourceOfStudentPage({
    Key? key,
    required this.resourceModelList,
    required this.courseModel,
    required this.moduleModel,
    this.teacher,
    required this.coordinator,
    required this.student,
    required this.studentResourceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recursos deste estudante'),
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
    Map<String, ResourceModel> map = Map.fromIterable(
      resourceModelList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in moduleModel.resourceOrder!) {
      if (map[index] != null) {
        bool temResource = studentResourceList.contains(map[index]!.id);
        list.add(Container(
            key: ValueKey(index),
            child: ResourceCard(
              resourceModel: map[index]!,
              color: temResource ? Colors.lime.shade900 : null,
            )));
      }
    }
    return list;
  }
}
