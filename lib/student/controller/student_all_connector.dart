import 'package:administracao/student/controller/student_action.dart';
import 'package:administracao/student/student_all.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class StudentAllConnector extends StatelessWidget {
  final String label;

  const StudentAllConnector({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StudentAllViewModel>(
      onInit: (store) async {
        await store.dispatch(ReadDocsStudentAction());
      },
      vm: () => StudentAllFactory(this),
      builder: (context, vm) => StudentAll(
        label: label,
        userListAll: vm.userListAll,
        insertUserInCourse: vm.insertUserInCourse,
      ),
    );
  }
}

class StudentAllFactory extends VmFactory<AppState, StudentAllConnector> {
  StudentAllFactory(widget) : super(widget);
  @override
  StudentAllViewModel fromStore() => StudentAllViewModel(
        userListAll: state.studentState.userListAll!,
        insertUserInCourse: (String user) async {
          print('Adicionando o student $user');
          await dispatch(CreateStudentCurrentStudentAction(
            id: user,
          ));
          await dispatch(ReadDocsStudentOfCourseStudentAction());
        },
      );
}

class StudentAllViewModel extends Vm {
  final List<UserModel> userListAll;
  final Function(String) insertUserInCourse;
  StudentAllViewModel({
    required this.userListAll,
    required this.insertUserInCourse,
  }) : super(equals: [
          userListAll,
        ]);
}
