import 'package:administracao/app_state.dart';
import 'package:administracao/course/course_action.dart';
import 'package:administracao/user/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:administracao/course/course_collegiate_page.dart';

class CourseCollegiateConnector extends StatelessWidget {
  final String courseId;
  const CourseCollegiateConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseCollegiateViewModel>(
      onInit: (store) async {
        await store.dispatch(SetCourseCurrentCourseAction(id: courseId));
        await store.dispatch(ReadDocsCollegiateCourseAction());
      },
      vm: () => CourseCollegiateViewModelFactory(this),
      builder: (context, vm) => CourseCollegiatePage(
        collegiate: vm.collegiate,
      ),
    );
  }
}

class CourseCollegiateViewModelFactory
    extends VmFactory<AppState, CourseCollegiateViewModel> {
  CourseCollegiateViewModelFactory(widget) : super(widget);
  @override
  CourseCollegiateViewModel fromStore() =>
      CourseCollegiateViewModel(collegiate: state.teacherState.teacherList!);
}

class CourseCollegiateViewModel extends Vm {
  final List<UserModel> collegiate;
  CourseCollegiateViewModel({
    required this.collegiate,
  }) : super(equals: [
          collegiate,
        ]);
}
