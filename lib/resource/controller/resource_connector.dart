import 'package:administracao/course/controller/course_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/module/controller/module_action.dart';
import 'package:administracao/module/controller/module_model.dart';
import 'package:administracao/resource/controller/resource_action.dart';
import 'package:administracao/resource/controller/resource_model.dart';
import 'package:administracao/resource/resource_page.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import 'package:administracao/app_state.dart';

class ResourceConnector extends StatelessWidget {
  final String moduleId;
  const ResourceConnector({
    Key? key,
    required this.moduleId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ResourceViewModel>(
      onInit: (store) async {
        await store.dispatch(SetModuleCurrentModuleAction(id: moduleId));
        // if (store.state.moduleState.moduleModelCurrent!.teacherUserId != null) {
        //   store.dispatch(SetTeacherCurrentTeacherAction(
        //       id: store.state.moduleState.moduleModelCurrent!.teacherUserId!));
        // } else {
        //   store.dispatch(SetTeacherCurrentTeacherAction(id: null));
        // }
        store.dispatch(StreamDocsResourceAction());
      },
      vm: () => ResourceFactory(this),
      builder: (context, vm) => ResourcePage(
        courseModel: vm.courseModel,
        moduleModel: vm.moduleModel,
        resourceModelList: vm.resourceModelList,
        teacher: vm.teacher,
        coordinator: vm.coordinator,
      ),
    );
  }
}

class ResourceFactory extends VmFactory<AppState, ResourceConnector> {
  ResourceFactory(widget) : super(widget);
  ResourceViewModel fromStore() => ResourceViewModel(
        courseModel: state.courseState.course!,
        coordinator: state.courseState.coordinator!,
        moduleModel: state.moduleState.moduleModelCurrent!,
        resourceModelList: state.resourceState.resourceModelList!,
        teacher: selectTeacher(),
      );
  selectTeacher() {
    if (state.moduleState.moduleModelCurrent!.teacherUserId != null) {
      UserModel? temp = CourseState.selectTeacherInCollegiate(
          state, state.moduleState.moduleModelCurrent!.teacherUserId!);
      return temp;
    }
    return null;
  }
}

class ResourceViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel coordinator;

  final ModuleModel moduleModel;
  final UserModel? teacher;
  final List<ResourceModel> resourceModelList;

  ResourceViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.moduleModel,
    this.teacher,
    required this.resourceModelList,
  }) : super(equals: [
          resourceModelList,
          courseModel,
          moduleModel,
        ]);
}
