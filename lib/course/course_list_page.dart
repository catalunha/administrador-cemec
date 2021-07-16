import 'package:administracao/course/course_card.dart';
import 'package:administracao/course/course_model.dart';
import 'package:flutter/material.dart';

class CourseListPage extends StatelessWidget {
  final List<CourseModel> courseModelList;
  const CourseListPage({
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
              alignment: Alignment.topRight,
              child: Wrap(
                children: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(
                            context,
                            '/course_archived',
                          ),
                      icon: Icon(Icons.archive))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: courseModelList
                    .map((e) => CourseCard(courseModel: e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(context, '/course_addedit', arguments: '');
        },
      ),
    );
  }
}
