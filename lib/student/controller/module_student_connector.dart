import 'package:administracao/module/controller/module_action.dart';
import 'package:administracao/student/controller/student_action.dart';
import 'package:administracao/student/module_student_page.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:flutter/material.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/module/controller/module_model.dart';

class ModuleOfStudentConnector extends StatelessWidget {
  final String userId;
  const ModuleOfStudentConnector({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleViewModel>(
      onInit: (store) async {
        store.dispatch(SelectStudentAndUserStudentAction(userId: userId));
        store.dispatch(StreamDocsModuleAction());
      },
      vm: () => ModuleViewModelFactory(this),
      builder: (context, vm) => ModuleStudentPage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        studentUser: vm.studentUser!,
        moduleModelList: vm.moduleModelList,
      ),
    );
  }
}

class ModuleViewModelFactory
    extends VmFactory<AppState, ModuleOfStudentConnector> {
  ModuleViewModelFactory(widget) : super(widget);
  ModuleViewModel fromStore() => ModuleViewModel(
        courseModel: state.courseState.course!,
        coordinator: state.courseState.coordinator!,
        studentUser: state.studentState.user!,
        moduleModelList: state.moduleState.moduleModelList!,
      );
}

class ModuleViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel? coordinator;
  final UserModel? studentUser;
  final List<ModuleModel> moduleModelList;
  ModuleViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.studentUser,
    required this.moduleModelList,
  }) : super(equals: [
          courseModel,
          coordinator,
          studentUser,
          moduleModelList,
        ]);
}
