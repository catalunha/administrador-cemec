import 'package:administracao/course/course_addedit_connector.dart';
import 'package:administracao/course/course_archived_connector.dart';
import 'package:administracao/course/course_list_connector.dart';
import 'package:administracao/module/module_addedit_connector.dart';
import 'package:administracao/module/module_connector.dart';
import 'package:administracao/resource/resource_connector.dart';
import 'package:flutter/material.dart';
import 'package:administracao/home/home_page_connector.dart';
import 'package:administracao/login/login_connector.dart';
import 'package:administracao/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/course': (BuildContext context) => CourseListConnector(),
    '/course_addedit': (BuildContext context) => CourseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/course_archived': (BuildContext context) => CourseArchivedConnector(),
    '/module': (BuildContext context) => ModuleConnector(
          courseId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/module_addedit': (BuildContext context) => ModuleAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/resource': (BuildContext context) => ResourceConnector(
          moduleId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
  };
}
