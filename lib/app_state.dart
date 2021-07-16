import 'package:administracao/coordinator/coordinator_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/course/course_state.dart';
import 'package:administracao/login/login_state.dart';
import 'package:administracao/module/module_state.dart';
import 'package:administracao/resource/resource_state.dart';
import 'package:administracao/upload/upload_state.dart';
import 'package:administracao/teacher/teacher_state.dart';
import 'package:administracao/user/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final TeacherState teacherState;
  final CoordinatorState coordinatorState;
  final UploadState uploadState;
  final CourseState courseState;
  final ModuleState moduleState;
  final ResourceState resourceState;
  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.teacherState,
    required this.coordinatorState,
    required this.uploadState,
    required this.courseState,
    required this.moduleState,
    required this.resourceState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        teacherState: TeacherState.initialState(),
        coordinatorState: CoordinatorState.initialState(),
        uploadState: UploadState.initialState(),
        courseState: CourseState.initialState(),
        moduleState: ModuleState.initialState(),
        resourceState: ResourceState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    TeacherState? teacherState,
    CoordinatorState? coordinatorState,
    UploadState? uploadState,
    CourseState? courseState,
    ModuleState? moduleState,
    ResourceState? resourceState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      teacherState: teacherState ?? this.teacherState,
      coordinatorState: coordinatorState ?? this.coordinatorState,
      uploadState: uploadState ?? this.uploadState,
      courseState: courseState ?? this.courseState,
      moduleState: moduleState ?? this.moduleState,
      resourceState: resourceState ?? this.resourceState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.moduleState == moduleState &&
        other.courseState == courseState &&
        other.uploadState == uploadState &&
        other.loginState == loginState &&
        other.coordinatorState == coordinatorState &&
        other.teacherState == teacherState &&
        other.userState == userState &&
        other.resourceState == resourceState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return courseState.hashCode ^
        moduleState.hashCode ^
        uploadState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        coordinatorState.hashCode ^
        teacherState.hashCode ^
        resourceState.hashCode ^
        wait.hashCode;
  }
}
