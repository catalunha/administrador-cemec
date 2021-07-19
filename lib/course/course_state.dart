import 'package:administracao/app_state.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class CourseState {
  final List<CourseModel>? courseModelList;
  final CourseModel? courseModelCurrent;
  final UserModel? coordinatorCurrent;

  static List<CourseModel> selectCourseNotArchived(AppState state) =>
      state.courseState.courseModelList!
          .where((element) => element.isArchivedByAdm == false)
          .toList();
  static List<CourseModel> selectCourseArchived(AppState state) =>
      state.courseState.courseModelList!
          .where((element) => element.isArchivedByAdm == true)
          .toList();
  static UserModel? selectCoordinator(AppState state, String coordinatorId) =>
      state.coordinatorState.coordinatorList!
          .firstWhereOrNull((element) => element.id == coordinatorId);
  CourseState({
    this.courseModelList,
    this.courseModelCurrent,
    this.coordinatorCurrent,
  });
  factory CourseState.initialState() => CourseState(
        courseModelList: [],
        courseModelCurrent: null,
        coordinatorCurrent: null,
      );
  CourseState copyWith({
    List<CourseModel>? courseModelList,
    CourseModel? courseModelCurrent,
    bool courseModelCurrentNull = false,
    UserModel? coordinatorCurrent,
    bool coordinatorCurrentNull = false,
  }) {
    return CourseState(
      courseModelList: courseModelList ?? this.courseModelList,
      courseModelCurrent: courseModelCurrentNull
          ? null
          : courseModelCurrent ?? this.courseModelCurrent,
      coordinatorCurrent: coordinatorCurrentNull
          ? null
          : coordinatorCurrent ?? this.coordinatorCurrent,
    );
  }

  @override
  String toString() =>
      'CourseState(courseModelCurrent: $courseModelCurrent, courseModelList: $courseModelList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseState &&
        other.courseModelCurrent == courseModelCurrent &&
        other.coordinatorCurrent == coordinatorCurrent &&
        listEquals(other.courseModelList, courseModelList);
  }

  @override
  int get hashCode =>
      coordinatorCurrent.hashCode ^
      courseModelCurrent.hashCode ^
      courseModelList.hashCode;
}
