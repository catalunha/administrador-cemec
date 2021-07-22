import 'package:administracao/coordinator/controller/coordinator_tile.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/course_tile.dart';
import 'package:administracao/module/controller/module_card_connector.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class ModulePage extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel? coordinator;

  final List<ModuleModel> moduleModelList;

  const ModulePage({
    Key? key,
    required this.moduleModelList,
    required this.courseModel,
    this.coordinator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Módulos deste curso'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
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
            '${moduleModelList.length} môdulo(s) e ${courseModel.collegiate!.length} professor(es)',
            style: AppTextStyles.titleBoldHeading,
          ),
          SizedBox(
            height: 5,
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: moduleModelList
          //           .map((e) => ModuleCardConnector(moduleModel: e))
          //           .toList(),
          //     ),
          //   ),
          // ),
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

  buildItens(BuildContext context) {
    List<Widget> list = [];
    Map<String, ModuleModel> map = Map.fromIterable(
      moduleModelList,
      key: (element) => element.id,
      value: (element) => element,
    );
    for (var index in courseModel.moduleOrder!) {
      if (map[index] != null) {
        list.add(Container(
            key: ValueKey(index),
            child: ModuleCardConnector(moduleModel: map[index]!)));
      }
    }
    return list;
  }
}
