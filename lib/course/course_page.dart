import 'package:administracao/course/controller/course_card_connector.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/theme/app_icon.dart';
import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  final List<CourseModel> courseModelList;
  const CoursePage({
    Key? key,
    required this.courseModelList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('0 cursos ativos.    '),
                  Text('${courseModelList.length} cursos propostos.    '),
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                            context,
                            '/course_archived',
                          ),
                      icon: Icon(AppIconData.archived))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: courseModelList
                    .map((e) => CourseCardConnector(courseModel: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () async {
      //     Navigator.pushNamed(context, '/course_addedit', arguments: '');
      //   },
      // ),
    );
  }
}
