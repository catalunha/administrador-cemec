import 'package:flutter/material.dart';

import 'package:administracao/user/user_model.dart';

class CourseCollegiatePage extends StatelessWidget {
  final List<UserModel> collegiate;

  const CourseCollegiatePage({
    Key? key,
    required this.collegiate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professores deste curso'),
      ),
    );
  }
}
