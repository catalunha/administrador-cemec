import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/teacher/teacher_tile.dart';
import 'package:administracao/theme/app_colors.dart';
import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:administracao/widget/text_description.dart';
import 'package:flutter/material.dart';

class ModuleCard extends StatelessWidget {
  final ModuleModel moduleModel;
  final UserModel? teacher;

  const ModuleCard({Key? key, required this.moduleModel, this.teacher})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 2,
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child:
                Text('${moduleModel.title}', style: AppTextStyles.trailingBold),
            color: AppColors.secondary,
          ),
          TeacherTile(teacher: teacher),
          TextDescription(
            firstWord: 'Descrição: ',
            text: moduleModel.description,
          ),
          TextDescription(
            firstWord: 'Ementa: ',
            text: moduleModel.syllabus,
          ),
          TextDescription(
            firstWord: 'Recursos: ',
            text: '${moduleModel.resourceOrder?.length}',
          ),
          TextDescription(
            firstWord: 'moduleId: ',
            text: moduleModel.id,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: RichText(
          //       text: TextSpan(
          //         style: DefaultTextStyle.of(context).style,
          //         children: [
          //           TextSpan(
          //               text: 'Descrição: ',
          //               style: AppTextStyles.captionBoldBody),
          //           TextSpan(
          //             text: '${moduleModel.description}',
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: RichText(
          //       text: TextSpan(
          //         style: DefaultTextStyle.of(context).style,
          //         children: [
          //           TextSpan(
          //               text: 'Ementa: ', style: AppTextStyles.captionBoldBody),
          //           TextSpan(
          //             text: '${moduleModel.syllabus}',
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: Text(
          //       '${moduleModel.id}',
          //       // textAlign: TextAlign.start,
          //     ),
          //   ),
          // ),
          Wrap(
            children: [
              // IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () async {
              //     Navigator.pushNamed(context, '/module_addedit',
              //         arguments: moduleModel.id);
              //   },
              // ),
              IconButton(
                icon: Icon(AppIconData.resourse),
                onPressed: () async {
                  Navigator.pushNamed(context, '/resource',
                      arguments: moduleModel.id);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
