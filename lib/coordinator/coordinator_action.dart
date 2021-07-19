import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/coordinator/coordinator_state.dart';

class SetCoordinatorCurrentCoordinatorAction extends ReduxAction<AppState> {
  final String? id;
  SetCoordinatorCurrentCoordinatorAction({
    required this.id,
  });
  @override
  AppState? reduce() {
    return state.copyWith(
      courseState: state.courseState.copyWith(
        coordinator: CoordinatorState.selectCoordinator(state, id!),
      ),
    );
  }
}
