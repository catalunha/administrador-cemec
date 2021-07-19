import 'package:administracao/user/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/course/course_model.dart';
import 'package:flutter/material.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/course/course_action.dart';
import 'package:administracao/module/module_action.dart';
import 'package:administracao/module/module_model.dart';
import 'package:administracao/module/module_page.dart';

class ModuleConnector extends StatelessWidget {
  final String courseId;
  const ModuleConnector({
    Key? key,
    required this.courseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ModuleViewModel>(
      onInit: (store) async {
        await store.dispatch(SetCourseCourseAction(id: courseId));
        store.dispatch(StreamDocsModuleAction());
      },
      vm: () => ModuleViewModelFactory(this),
      builder: (context, vm) => ModulePage(
        courseModel: vm.courseModel,
        coordinator: vm.coordinator,
        moduleModelList: vm.moduleModelList,
      ),
    );
  }
}

class ModuleViewModelFactory extends VmFactory<AppState, ModuleConnector> {
  ModuleViewModelFactory(widget) : super(widget);
  ModuleViewModel fromStore() => ModuleViewModel(
        courseModel: state.courseState.course!,
        coordinator: state.courseState.coordinator!,
        moduleModelList: state.moduleState.moduleModelList!,
      );
}

class ModuleViewModel extends Vm {
  final CourseModel courseModel;
  final UserModel? coordinator;
  final List<ModuleModel> moduleModelList;
  ModuleViewModel({
    required this.courseModel,
    required this.coordinator,
    required this.moduleModelList,
  }) : super(equals: [
          courseModel,
          coordinator,
          moduleModelList,
        ]);
}
