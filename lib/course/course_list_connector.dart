import 'package:administracao/course/course_list_page.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/course/course_action.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/course/course_state.dart';

import 'package:flutter/material.dart';

class CourseListConnector extends StatelessWidget {
  const CourseListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      onInit: (store) => store.dispatch(StreamDocsCourseAction()),
      builder: (context, vm) => CourseListPage(
        courseModelList: vm.courseModelList,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, CourseListConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        courseModelList: CourseState.selectCourseNotArchived(state),
      );
}

class HomeViewModel extends Vm {
  final List<CourseModel> courseModelList;
  HomeViewModel({
    required this.courseModelList,
  }) : super(equals: [
          courseModelList,
        ]);
}
