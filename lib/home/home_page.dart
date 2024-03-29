import 'package:administracao/course/course_card.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/theme/app_colors.dart';
import 'package:administracao/theme/app_images.dart';
import 'package:administracao/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String photoUrl;
  final String displayName;
  // final String phoneNumber;
  final String email;
  final String uid;
  final String id;
  final VoidCallback signOut;
  // final List<CourseModel> courseModelList;
  const HomePage({
    Key? key,
    required this.photoUrl,
    required this.displayName,
    required this.signOut,
    // required this.phoneNumber,
    required this.email,
    // required this.courseModelList,
    required this.uid,
    required this.id,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Container(
          // height: 110,
          // color: AppColors.primary,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: ListTile(
                  onTap: signOut,
                  title: Text(
                    'Olá, $displayName',
                    style: AppTextStyles.titleRegular,
                  ),
                  subtitle: Text('Cursos e Pessoas sob sua ADMINISTRAÇÃO.'),
                  trailing: Tooltip(
                    message: 'email: $email\nid: $id\nuid: $uid',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        photoUrl,
                        height: 58,
                        width: 58,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/team',
            ),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      AppImages.team,
                      width: 100,
                      height: 93,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Equipe',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.titleHome,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(
              context,
              '/course',
            ),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      AppImages.course,
                      width: 100,
                      height: 93,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cursos',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.titleHome,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
