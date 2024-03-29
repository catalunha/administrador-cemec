import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:administracao/course/controller/course_model.dart';

class CourseTile extends StatelessWidget {
  final CourseModel? courseModel;

  const CourseTile({
    Key? key,
    required this.courseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return courseModel != null
        ? ListTile(
            leading: courseModel!.iconUrl == null
                ? Icon(AppIconData.undefined)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      courseModel!.iconUrl!,
                      height: 58,
                      width: 58,
                    ),
                  ),
            title:
                Text(courseModel!.title, style: AppTextStyles.titleBoldHeading),
            // subtitle: Text(
            //     'Com ${courseModel?.moduleOrder?.length} môdulos\ncourseId: ${courseModel!.id}'),
            subtitle: Text('courseId: ${courseModel!.id}'),
          )
        : ListTile(
            leading: Icon(
              AppIconData.undefined,
            ),
            title: Text('Curso não disponivel'),
          );
  }
}
