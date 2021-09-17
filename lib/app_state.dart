import 'package:administracao/coordinator/controller/coordinator_state.dart';
import 'package:administracao/situation/controller/situation_state.dart';
import 'package:administracao/student/controller/student_state.dart';
import 'package:administracao/team/controller/team_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/course/controller/course_state.dart';
import 'package:administracao/login/controller/login_state.dart';
import 'package:administracao/module/controller/module_state.dart';
import 'package:administracao/resource/controller/resource_state.dart';
import 'package:administracao/upload/controller/upload_state.dart';
import 'package:administracao/teacher/controller/teacher_state.dart';
import 'package:administracao/user/controller/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final TeamState teamState;
  final TeacherState teacherState;
  final CoordinatorState coordinatorState;
  final UploadState uploadState;
  final CourseState courseState;
  final ModuleState moduleState;
  final ResourceState resourceState;
  final SituationState situationState;
  final StudentState studentState;

  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.teacherState,
    required this.coordinatorState,
    required this.teamState,
    required this.uploadState,
    required this.courseState,
    required this.moduleState,
    required this.resourceState,
    required this.situationState,
    required this.studentState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        teacherState: TeacherState.initialState(),
        coordinatorState: CoordinatorState.initialState(),
        teamState: TeamState.initialState(),
        uploadState: UploadState.initialState(),
        courseState: CourseState.initialState(),
        moduleState: ModuleState.initialState(),
        resourceState: ResourceState.initialState(),
        situationState: SituationState.initialState(),
        studentState: StudentState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    TeacherState? teacherState,
    CoordinatorState? coordinatorState,
    TeamState? teamState,
    UploadState? uploadState,
    CourseState? courseState,
    ModuleState? moduleState,
    ResourceState? resourceState,
    SituationState? situationState,
    StudentState? studentState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      teacherState: teacherState ?? this.teacherState,
      coordinatorState: coordinatorState ?? this.coordinatorState,
      teamState: teamState ?? this.teamState,
      uploadState: uploadState ?? this.uploadState,
      courseState: courseState ?? this.courseState,
      moduleState: moduleState ?? this.moduleState,
      resourceState: resourceState ?? this.resourceState,
      situationState: situationState ?? this.situationState,
      studentState: studentState ?? this.studentState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.studentState == studentState &&
        other.moduleState == moduleState &&
        other.courseState == courseState &&
        other.uploadState == uploadState &&
        other.loginState == loginState &&
        other.coordinatorState == coordinatorState &&
        other.teacherState == teacherState &&
        other.teamState == teamState &&
        other.userState == userState &&
        other.resourceState == resourceState &&
        other.situationState == situationState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return courseState.hashCode ^
        studentState.hashCode ^
        moduleState.hashCode ^
        uploadState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        coordinatorState.hashCode ^
        teacherState.hashCode ^
        teamState.hashCode ^
        resourceState.hashCode ^
        situationState.hashCode ^
        wait.hashCode;
  }
}
