import 'package:administracao/course/controller/course_addedit_connector.dart';
import 'package:administracao/course/controller/course_archived_connector.dart';
import 'package:administracao/course/controller/course_connector.dart';
import 'package:administracao/course/controller/course_student_list_connector.dart';
import 'package:administracao/course/controller/course_collegiate_connector.dart';
import 'package:administracao/module/controller/module_connector.dart';
import 'package:administracao/resource/controller/resource_connector.dart';
import 'package:administracao/team/controller/team_page_connector.dart';
import 'package:flutter/material.dart';
import 'package:administracao/home/controller/home_page_connector.dart';
import 'package:administracao/login/controller/login_connector.dart';
import 'package:administracao/splash/controller/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/course': (BuildContext context) => CourseConnector(),
    '/course_addedit': (BuildContext context) => CourseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/course_teacher': (BuildContext context) => CourseCollegiateConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/course_student': (BuildContext context) => CourseStudentListConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/course_archived': (BuildContext context) => CourseArchivedConnector(),
    '/module': (BuildContext context) => ModuleConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/resource': (BuildContext context) => ResourceConnector(
          moduleId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/team': (BuildContext context) => TeamPageConnector(),
  };
}
