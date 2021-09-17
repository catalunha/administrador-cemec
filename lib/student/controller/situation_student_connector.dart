import 'package:administracao/course/controller/course_state.dart';
import 'package:administracao/student/situation_student_page.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/module/controller/module_action.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/situation/controller/situation_action.dart';
import 'package:administracao/situation/controller/situation_model.dart';
import 'package:administracao/user/controller/user_model.dart';

class SituationOfStudentConnector extends StatelessWidget {
  final String moduleId;
  const SituationOfStudentConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SituationViewModel>(
      onInit: (store) async {
        await store.dispatch(SetModuleCurrentModuleAction(id: moduleId));
        store.dispatch(StreamDocsSituationAction());
      },
      vm: () => SituationFactory(this),
      builder: (context, vm) => SituationOfStudentPage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        moduleModel: vm.moduleModel,
        teacher: vm.teacher,
        student: vm.student,
        situationModelList: vm.situationModelList,
        studentSituationList: vm.studentSituationList,
      ),
    );
  }
}

class SituationFactory
    extends VmFactory<AppState, SituationOfStudentConnector> {
  SituationFactory(widget) : super(widget);
  SituationViewModel fromStore() => SituationViewModel(
        courseModel: state.courseState.course,
        coordinator: state.courseState.coordinator!,
        moduleModel: state.moduleState.moduleModelCurrent!,
        teacher: selectTeacher(),
        student: state.studentState.user!,
        situationModelList: state.situationState.situationList!,
        studentSituationList: studentSituationList(),
      );
  selectTeacher() {
    if (state.moduleState.moduleModelCurrent!.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, state.moduleState.moduleModelCurrent!.teacherUserId!);
      return temp;
    }
    return null;
  }

  studentSituationList() {
    List<String>? studentSituationList = [];
    if (state.studentState.studentCurrent!.situationMap
        .containsKey(widget!.moduleId)) {
      studentSituationList =
          state.studentState.studentCurrent!.situationMap[widget!.moduleId];
    }
    print(studentSituationList);
    return studentSituationList;
  }
}

class SituationViewModel extends Vm {
  final CourseModel? courseModel;
  final UserModel coordinator;
  final ModuleModel moduleModel;
  final UserModel? teacher;
  final UserModel student;
  final List<SituationModel> situationModelList;
  final List<String> studentSituationList;
  // final Function(List<String>) onChangeSituationOrder;

  SituationViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.moduleModel,
    required this.teacher,
    required this.student,
    required this.situationModelList,
    required this.studentSituationList,
  }) : super(equals: [
          courseModel,
          coordinator,
          moduleModel,
          teacher,
          student,
          situationModelList,
          studentSituationList,
        ]);
}
