import 'package:administracao/app_state.dart';
import 'package:administracao/student/controller/student_model.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/foundation.dart';
// import 'package:collection/collection.dart';

class StudentState {
  final UserModel? user;
  final StudentModel? studentCurrent;
  final List<UserModel>? userListOfCourse;
  final List<StudentModel>? studentListOfCourse;
  final List<UserModel>? userListAll;
  static StudentModel? selectStudentOfCourse(AppState state, String userId) =>
      state.studentState.studentListOfCourse!
          .firstWhere((element) => element.userId == userId);
  static UserModel? selectUsertOfCourse(AppState state, String userId) =>
      state.studentState.userListOfCourse!
          .firstWhere((element) => element.id == userId);
  StudentState({
    this.user,
    this.userListOfCourse,
    this.studentListOfCourse,
    this.studentCurrent,
    this.userListAll,
  });
  factory StudentState.initialState() => StudentState(
        userListOfCourse: [],
        studentListOfCourse: [],
        studentCurrent: null,
        user: null,
        userListAll: [],
      );

  StudentState copyWith({
    StudentModel? studentCurrent,
    bool studentCurrentNull = false,
    UserModel? user,
    bool userNull = false,
    List<UserModel>? userListAll,
    List<UserModel>? userListOfCourse,
    List<StudentModel>? studentListOfCourse,
  }) {
    return StudentState(
      studentCurrent:
          studentCurrentNull ? null : studentCurrent ?? this.studentCurrent,
      user: userNull ? null : user ?? this.user,
      userListAll: userListAll ?? this.userListAll,
      userListOfCourse: userListOfCourse ?? this.userListOfCourse,
      studentListOfCourse: studentListOfCourse ?? this.studentListOfCourse,
    );
  }

  @override
  String toString() =>
      'StudentState(studentCurrent: $studentCurrent, studentList: $userListAll)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentState &&
        other.user == user &&
        other.studentCurrent == studentCurrent &&
        listEquals(other.userListOfCourse, userListOfCourse) &&
        listEquals(other.studentListOfCourse, studentListOfCourse) &&
        listEquals(other.userListAll, userListAll);
  }

  @override
  int get hashCode =>
      studentListOfCourse.hashCode ^
      user.hashCode ^
      studentCurrent.hashCode ^
      userListAll.hashCode ^
      userListOfCourse.hashCode;
}
