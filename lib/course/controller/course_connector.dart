import 'package:administracao/course/course_page.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/course/controller/course_action.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/controller/course_state.dart';

import 'package:flutter/material.dart';

class CourseConnector extends StatelessWidget {
  const CourseConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseViewModel>(
      vm: () => CourseViewModelFactory(this),
      onInit: (store) => store.dispatch(StreamDocsCourseAction()),
      builder: (context, vm) => CoursePage(
        courseModelList: vm.courseModelList,
      ),
    );
  }
}

class CourseViewModelFactory extends VmFactory<AppState, CourseConnector> {
  CourseViewModelFactory(widget) : super(widget);
  @override
  CourseViewModel fromStore() => CourseViewModel(
        courseModelList: CourseState.selectCourseNotArchived(state),
      );
}

class CourseViewModel extends Vm {
  final List<CourseModel> courseModelList;
  CourseViewModel({
    required this.courseModelList,
  }) : super(equals: [
          courseModelList,
        ]);
}
