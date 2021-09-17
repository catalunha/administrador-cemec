import 'package:administracao/teacher/controller/teacher_action.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:administracao/app_state.dart';
import 'package:administracao/course/controller/course_action.dart';
import 'package:administracao/course/course_collegiate_page.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/user/controller/user_model.dart';

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
        await store.dispatch(SetCourseCourseAction(id: courseId));
        // store.dispatch(SetCoordinatorCurrentCoordinatorAction(
        //     id: store.state.courseState.course!.coordinatorUserId));
        // await store.dispatch(GetCoordinatorOfCourseCourseAction(
        //     coordinatorId: store.state.courseState.course!.coordinatorUserId));
        // await store.dispatch(GetDocsCollegiateCourseAction());
      },
      vm: () => CourseCollegiateViewModelFactory(this),
      builder: (context, vm) => CourseCollegiatePage(
        collegiate: vm.collegiate,
        coordinator: vm.coordinator,
        courseModel: vm.courseModel,
        getTeacher: vm.getTeacher,
      ),
    );
  }
}

class CourseCollegiateViewModelFactory
    extends VmFactory<AppState, CourseCollegiateConnector> {
  CourseCollegiateViewModelFactory(widget) : super(widget);
  @override
  CourseCollegiateViewModel fromStore() => CourseCollegiateViewModel(
        collegiate: state.courseState.collegiate!,
        coordinator: state.courseState.coordinator,
        courseModel: state.courseState.course,
        getTeacher: () async {
          await dispatch(ReadDocsTeacherAction());
        },
      );
}

class CourseCollegiateViewModel extends Vm {
  final List<UserModel> collegiate;
  final UserModel? coordinator;
  final CourseModel? courseModel;
  final VoidCallback getTeacher;
  CourseCollegiateViewModel({
    required this.collegiate,
    required this.coordinator,
    required this.courseModel,
    required this.getTeacher,
  }) : super(equals: [
          collegiate,
          coordinator,
          courseModel,
        ]);
}
