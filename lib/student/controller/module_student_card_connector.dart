import 'package:administracao/course/controller/course_state.dart';
import 'package:administracao/student/controller/student_action.dart';
import 'package:administracao/student/controller/student_model.dart';
import 'package:administracao/student/module_student_card.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class ModuleStudentCardConnector extends StatelessWidget {
  final ModuleModel moduleModel;

  const ModuleStudentCardConnector({Key? key, required this.moduleModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleCardViewModel>(
      vm: () => ModuleCardFactory(this),
      builder: (context, vm) => ModuleStudentCard(
        moduleModel: moduleModel,
        teacher: vm.teacher,
        countResourcesOfStudent: vm.countResourcesOfStudent,
        countSituationOfStudent: vm.countSituationOfStudent,
        isModuleOfStudent: vm.isModuleOfStudent,
        updateModuleOfStudent: vm.updateModuleOfStudent,
      ),
    );
  }
}

class ModuleCardFactory
    extends VmFactory<AppState, ModuleStudentCardConnector> {
  ModuleCardFactory(widget) : super(widget);
  @override
  ModuleCardViewModel fromStore() => ModuleCardViewModel(
      teacher: selectTeacher(),
      countResourcesOfStudent: countResourcesOfStudent(),
      countSituationOfStudent: countSituationOfStudent(),
      isModuleOfStudent: isModuleOfStudent(),
      updateModuleOfStudent: (String moduleId) {
        print('Adicionar modulo $moduleId a este estudante');
        dispatch(UpdateModuleOfStudent(moduleId: moduleId));
      });
  isModuleOfStudent() {
    bool temp = false;
    temp = state.studentState.studentCurrent!.resourceMap
        .containsKey(widget!.moduleModel.id);
    return temp;
  }

  countResourcesOfStudent() {
    int qde = 0;
    List<String>? resourceIdList =
        state.studentState.studentCurrent!.resourceMap[widget!.moduleModel.id];
    if (resourceIdList != null) {
      qde = resourceIdList.length;
    }
    return qde;
  }

  countSituationOfStudent() {
    int qde = 0;
    List<String>? situationList =
        state.studentState.studentCurrent!.situationMap[widget!.moduleModel.id];
    if (situationList != null) {
      qde = situationList.length;
    }
    return qde;
  }

  selectTeacher() {
    if (widget!.moduleModel.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, widget!.moduleModel.teacherUserId!);
      return temp;
    }
    return null;
  }
}

class ModuleCardViewModel extends Vm {
  final UserModel? teacher;
  final int countResourcesOfStudent;
  final int countSituationOfStudent;
  final bool isModuleOfStudent;
  final Function(String) updateModuleOfStudent;
  ModuleCardViewModel({
    required this.teacher,
    required this.countResourcesOfStudent,
    required this.countSituationOfStudent,
    required this.isModuleOfStudent,
    required this.updateModuleOfStudent,
  }) : super(equals: [
          teacher,
          countResourcesOfStudent,
          countSituationOfStudent,
          isModuleOfStudent,
        ]);
}
