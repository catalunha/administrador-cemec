import 'package:administracao/app_state.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

class TeacherState {
  final UserModel? teacherCurrent;
  final List<UserModel>? teacherList;
  final List<UserModel>? collegiate;
  static UserModel? selectTeacher(AppState state, String teacherId) =>
      state.teacherState.teacherList!
          .firstWhereOrNull((element) => element.id == teacherId);
  TeacherState({
    this.teacherCurrent,
    this.teacherList,
    this.collegiate,
  });
  factory TeacherState.initialState() => TeacherState(
        teacherCurrent: null,
        teacherList: [],
        collegiate: [],
      );

  TeacherState copyWith({
    UserModel? teacherCurrent,
    bool teacherCurrentNull = false,
    List<UserModel>? teacherList,
    List<UserModel>? collegiate,
  }) {
    return TeacherState(
      teacherCurrent:
          teacherCurrentNull ? null : teacherCurrent ?? this.teacherCurrent,
      teacherList: teacherList ?? this.teacherList,
      collegiate: collegiate ?? this.collegiate,
    );
  }

  @override
  String toString() =>
      'TeacherState(teacherCurrent: $teacherCurrent, teacherList: $teacherList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeacherState &&
        other.teacherCurrent == teacherCurrent &&
        listEquals(other.teacherList, teacherList) &&
        listEquals(other.collegiate, collegiate);
  }

  @override
  int get hashCode =>
      collegiate.hashCode ^ teacherCurrent.hashCode ^ teacherList.hashCode;
}
