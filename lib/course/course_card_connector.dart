import 'package:administracao/app_state.dart';
import 'package:administracao/coordinator/coordinator_state.dart';
import 'package:administracao/course/course_card.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/user/user_model.dart';
import 'package:async_redux/async_redux.dart';

import 'package:flutter/material.dart';

class CourseCardConnector extends StatelessWidget {
  final CourseModel courseModel;

  const CourseCardConnector({Key? key, required this.courseModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CourseCardViewModel>(
      vm: () => CourseCardFactory(this),
      builder: (context, vm) => CourseCard(
        courseModel: courseModel,
        coordinator: vm.coordinator,
      ),
    );
  }
}

class CourseCardFactory extends VmFactory<AppState, CourseCardConnector> {
  CourseCardFactory(widget) : super(widget);
  @override
  CourseCardViewModel fromStore() => CourseCardViewModel(
        coordinator: CoordinatorState.selectCoordinator(
            state, widget!.courseModel.coordinatorUserId),
      );
}

class CourseCardViewModel extends Vm {
  final UserModel? coordinator;
  CourseCardViewModel({
    required this.coordinator,
  }) : super(equals: [
          coordinator,
        ]);
}
