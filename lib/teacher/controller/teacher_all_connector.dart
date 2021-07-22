import 'package:administracao/course/controller/course_action.dart';
import 'package:administracao/teacher/teacher_all.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class TeacherAllConnector extends StatelessWidget {
  final String label;

  const TeacherAllConnector({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeacherAllViewModel>(
      vm: () => TeacherAllFactory(this),
      builder: (context, vm) => TeacherAll(
        label: label,
        teacherList: vm.teacherList,
        updateTeacherInCollegiate: vm.updateTeacherInCollegiate,
      ),
    );
  }
}

class TeacherAllFactory extends VmFactory<AppState, TeacherAllConnector> {
  TeacherAllFactory(widget) : super(widget);
  @override
  TeacherAllViewModel fromStore() => TeacherAllViewModel(
        teacherList: state.teacherState.teacherList!,
        updateTeacherInCollegiate: (String teacherId, bool isUnionOrRemove) {
          dispatch(UpdateTeacherInCollegiateCourseAction(
            teacherId: teacherId,
            isUnionOrRemove: isUnionOrRemove,
          ));
          // dispatch(ReadDocsCollegiateCourseAction());
        },
      );

  List<UserModel> teacherList() {
    print('collegiate ${state.courseState.course?.collegiate}');
    List<UserModel> teacherThisCourse = [];
    for (UserModel teacher in state.teacherState.teacherList!) {
      if (state.courseState.course!.collegiate!.contains(teacher.id)) {
        teacherThisCourse.add(teacher);
      }
    }
    return teacherThisCourse;
    // return state.teacherState.teacherList ?? [];
  }
}

class TeacherAllViewModel extends Vm {
  final List<UserModel> teacherList;
  final Function(String, bool) updateTeacherInCollegiate;
  TeacherAllViewModel({
    required this.teacherList,
    required this.updateTeacherInCollegiate,
  }) : super(equals: [
          teacherList,
        ]);
}
