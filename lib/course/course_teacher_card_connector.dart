import 'package:administracao/course/course_action.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:administracao/app_state.dart';
import 'package:administracao/user/user_model.dart';

import 'course_teacher_card.dart';

class CourseTeacherCardConnector extends StatelessWidget {
  final UserModel teacher;
  const CourseTeacherCardConnector({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseTeacherCardViewModel>(
      vm: () => CourseTeacherCardViewModelFactory(this),
      builder: (context, vm) => CourseTeacherCard(
        teacher: teacher,
        updateTeacherInCollegiate: vm.updateTeacherInCollegiate,
      ),
    );
  }
}

class CourseTeacherCardViewModelFactory
    extends VmFactory<AppState, CourseTeacherCardConnector> {
  CourseTeacherCardViewModelFactory(widget) : super(widget);
  @override
  CourseTeacherCardViewModel fromStore() => CourseTeacherCardViewModel(
        updateTeacherInCollegiate: (String teacherId, bool isUnionOrRemove) {
          dispatch(UpdateTeacherInCollegiateCourseAction(
            teacherId: teacherId,
            isUnionOrRemove: isUnionOrRemove,
          ));
          // dispatch(ReadDocsCollegiateCourseAction());
        },
      );
}

class CourseTeacherCardViewModel extends Vm {
  final Function(String, bool) updateTeacherInCollegiate;
  CourseTeacherCardViewModel({
    required this.updateTeacherInCollegiate,
  }) : super(equals: []);
}
