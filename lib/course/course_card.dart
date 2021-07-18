import 'package:administracao/coordinator/coordinator_tile.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final CourseModel courseModel;
  final UserModel? coordinator;

  const CourseCard({
    Key? key,
    required this.courseModel,
    required this.coordinator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            leading: courseModel.iconUrl == null
                ? Icon(Icons.favorite_outline_rounded)
                : Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(courseModel.iconUrl!),
                      ),
                    ),
                  ),
            title: Text('${courseModel.title}',
                style: AppTextStyles.titleBoldHeading),
          ),
          CoordinatorTile(
            coordinator: coordinator,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Descrição: ',
                        style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.description}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Ementa: ', style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.syllabus}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                        text: 'Môdulos: ',
                        style: AppTextStyles.captionBoldBody),
                    TextSpan(
                      text: '${courseModel.moduleOrder?.length}',
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                '${courseModel.id}',
              ),
            ),
          ),
          Wrap(
            children: [
              IconButton(
                tooltip: 'Professores deste curso',
                icon: Icon(Icons.assignment_ind_outlined),
                onPressed: () async {
                  Navigator.pushNamed(context, '/course_teacher',
                      arguments: courseModel.id);
                },
              ),
              IconButton(
                tooltip: 'alunos deste curso',
                icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                onPressed: () async {
                  Navigator.pushNamed(context, '/course_student',
                      arguments: courseModel.id);
                },
              ),
              // IconButton(
              //   tooltip: 'Editar este curso',
              //   icon: Icon(Icons.edit),
              //   onPressed: () async {
              //     Navigator.pushNamed(context, '/course_addedit',
              //         arguments: courseModel.id);
              //   },
              // ),
              IconButton(
                tooltip: 'Modulos deste curso',
                icon: Icon(Icons.play_lesson_outlined),
                onPressed: () async {
                  Navigator.pushNamed(context, '/module',
                      arguments: courseModel.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
