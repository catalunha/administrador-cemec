import 'package:flutter/material.dart';
import 'package:administracao/home/home_page_connector.dart';
import 'package:administracao/login/login_connector.dart';
import 'package:administracao/splash/splash_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
  };
}
