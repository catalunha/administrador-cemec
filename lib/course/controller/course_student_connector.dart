import 'package:administracao/app_state.dart';
import 'package:administracao/course/controller/course_action.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/course/course_student_page.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class CourseStudentConnector extends StatelessWidget {
  final String courseId;
  const CourseStudentConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseStudentViewModel>(
      onInit: (store) async {
        await store.dispatch(SetCourseCourseAction(id: courseId));
      },
      vm: () => CourseStudentViewModelFactory(this),
      builder: (context, vm) => CourseStudentPage(
        studentListOfCourse: vm.studentListOfCourse,
        coordinator: vm.coordinador,
        courseModel: vm.courseModel,
      ),
    );
  }
}

class CourseStudentViewModelFactory
    extends VmFactory<AppState, CourseStudentConnector> {
  CourseStudentViewModelFactory(widget) : super(widget);
  @override
  CourseStudentViewModel fromStore() => CourseStudentViewModel(
        coordinador: state.courseState.coordinator!,
        courseModel: state.courseState.course!,
        studentListOfCourse: state.studentState.userListOfCourse ?? [],
      );
}

class CourseStudentViewModel extends Vm {
  final List<UserModel> studentListOfCourse;

  final UserModel coordinador;
  final CourseModel courseModel;
  CourseStudentViewModel({
    required this.studentListOfCourse,
    required this.coordinador,
    required this.courseModel,
  }) : super(equals: [
          studentListOfCourse,
          coordinador,
          courseModel,
        ]);
}
