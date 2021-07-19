import 'package:administracao/course/course_action.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/teacher/teacher_list.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class TeacherListConnector extends StatelessWidget {
  final String label;

  const TeacherListConnector({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeacherListViewModel>(
      vm: () => TeacherListFactory(this),
      builder: (context, vm) => TeacherList(
        label: label,
        teacherList: vm.teacherList,
        updateTeacherInCollegiate: vm.updateTeacherInCollegiate,
      ),
    );
  }
}

class TeacherListFactory extends VmFactory<AppState, TeacherListConnector> {
  TeacherListFactory(widget) : super(widget);
  @override
  TeacherListViewModel fromStore() => TeacherListViewModel(
        teacherList: teacherList(),
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

class TeacherListViewModel extends Vm {
  final List<UserModel> teacherList;
  final Function(String, bool) updateTeacherInCollegiate;
  TeacherListViewModel({
    required this.teacherList,
    required this.updateTeacherInCollegiate,
  }) : super(equals: [
          teacherList,
        ]);
}
