import 'package:administracao/app_state.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class CourseState {
  final List<CourseModel>? courseList;
  final CourseModel? course;
  final UserModel? coordinator;
  final List<UserModel>? collegiate;

  static List<CourseModel> selectCourseNotArchived(AppState state) =>
      state.courseState.courseList!
          .where((element) => element.isArchivedByAdm == false)
          .toList();
  static List<CourseModel> selectCourseArchived(AppState state) =>
      state.courseState.courseList!
          .where((element) => element.isArchivedByAdm == true)
          .toList();
  static UserModel? selectTeacherInCollegiate(
          AppState state, String teacherId) =>
      state.courseState.collegiate!
          .firstWhereOrNull((element) => element.id == teacherId);
  CourseState({
    this.courseList,
    this.course,
    this.coordinator,
    this.collegiate,
  });
  factory CourseState.initialState() => CourseState(
        courseList: [],
        course: null,
        coordinator: null,
        collegiate: [],
      );
  CourseState copyWith({
    List<CourseModel>? courseList,
    CourseModel? course,
    bool courseSetNull = false,
    UserModel? coordinator,
    bool coordinatorSetNull = false,
    List<UserModel>? collegiate,
  }) {
    return CourseState(
      courseList: courseList ?? this.courseList,
      course: courseSetNull ? null : course ?? this.course,
      coordinator: coordinatorSetNull ? null : coordinator ?? this.coordinator,
      collegiate: collegiate ?? this.collegiate,
    );
  }

  @override
  String toString() =>
      'CourseState(courseModelCurrent: $course, courseModelList: $courseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseState &&
        other.course == course &&
        other.coordinator == coordinator &&
        listEquals(other.collegiate, collegiate) &&
        listEquals(other.courseList, courseList);
  }

  @override
  int get hashCode =>
      collegiate.hashCode ^
      coordinator.hashCode ^
      course.hashCode ^
      courseList.hashCode;
}
