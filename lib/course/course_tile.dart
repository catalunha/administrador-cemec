import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:administracao/course/course_model.dart';

class CourseTile extends StatelessWidget {
  final CourseModel? courseModel;

  const CourseTile({
    Key? key,
    required this.courseModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: courseModel?.iconUrl == null
          ? Icon(AppIconData.undefined)
          : Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(courseModel!.iconUrl!),
                ),
              ),
            ),
      title:
          Text('${courseModel?.title}', style: AppTextStyles.titleBoldHeading),
    );
  }
}
