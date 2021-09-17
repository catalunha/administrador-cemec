import 'package:administracao/app_state.dart';
import 'package:administracao/course/controller/course_student_connector.dart';
import 'package:administracao/student/controller/student_action.dart';
import 'package:administracao/student/student_card.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class StudentCardConnector extends StatelessWidget {
  final UserModel user;
  const StudentCardConnector({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StudentCardViewModel>(
      vm: () => StudentCardViewModelFactory(this),
      builder: (context, vm) => StudentCard(
          user: user, removeStudentOfCourse: vm.removeStudentOfCourse),
    );
  }
}

class StudentCardViewModelFactory
    extends VmFactory<AppState, StudentCardConnector> {
  StudentCardViewModelFactory(widget) : super(widget);
  @override
  StudentCardViewModel fromStore() =>
      StudentCardViewModel(removeStudentOfCourse: (String userId) {
        print('removendo aluno: $userId');
        dispatch(RemoveStudentDocStudentAction(userId: userId));
      });
}

class StudentCardViewModel extends Vm {
  final Function(String) removeStudentOfCourse;
  StudentCardViewModel({required this.removeStudentOfCourse})
      : super(equals: []);
}
