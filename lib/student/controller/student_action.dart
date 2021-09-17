import 'package:administracao/course/controller/course_model.dart';
import 'package:administracao/student/controller/student_model.dart';
import 'package:administracao/student/controller/student_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:collection/collection.dart';

class ReadDocsStudentAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(UserModel.collection)
        .where('appList', arrayContains: 'student')
        .get();
    List<UserModel> studentList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => UserModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    dispatch(SetStudentListStudentAction(studentList: studentList));
    return null;
  }
}

class SetStudentListStudentAction extends ReduxAction<AppState> {
  final List<UserModel> studentList;

  SetStudentListStudentAction({required this.studentList});
  @override
  AppState reduce() {
    return state.copyWith(
      studentState: state.studentState.copyWith(
        userListAll: studentList,
      ),
    );
  }
}

class ReadDocsStudentOfCourseStudentAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(StudentModel.collection)
        .where('courseId', isEqualTo: state.courseState.course!.id)
        .get();
    List<StudentModel> studentListOfCourse = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => StudentModel.fromMap(
            queryDocumentSnapshot.id,
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    dispatch(SetStudentListOfCourseStudentAction(
        studentListOfCourse: studentListOfCourse));
    return null;
  }
}

class SetStudentListOfCourseStudentAction extends ReduxAction<AppState> {
  final List<StudentModel> studentListOfCourse;

  SetStudentListOfCourseStudentAction({required this.studentListOfCourse});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final List<UserModel>? userListOfCourse = [];
    print('studentListOfCourse: ${studentListOfCourse.length}');
    for (var user in studentListOfCourse) {
      var a = await firebaseFirestore
          .collection(UserModel.collection)
          .doc(user.userId)
          .get();
      userListOfCourse?.add(UserModel.fromMap(user.userId, a.data()!));
    }

    return state.copyWith(
      studentState: state.studentState.copyWith(
          userListOfCourse: userListOfCourse,
          studentListOfCourse: studentListOfCourse),
    );
  }
}

class CreateStudentCurrentStudentAction extends ReduxAction<AppState> {
  final String id;

  CreateStudentCurrentStudentAction({required this.id});
  @override
  AppState reduce() {
    StudentModel studentModel;

    studentModel = StudentModel('',
        userId: id,
        courseId: state.courseState.course!.id,
        resourceMap: {},
        situationMap: {});

    return state.copyWith(
        studentState:
            state.studentState.copyWith(studentCurrent: studentModel));
  }

  void after() {
    dispatch(CreateStudentDocStudentAction(
      studentModel: state.studentState.studentCurrent!,
    ));
  }
}

class CreateStudentDocStudentAction extends ReduxAction<AppState> {
  final StudentModel studentModel;

  CreateStudentDocStudentAction({required this.studentModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(StudentModel.collection).doc();
    await docRef.set(studentModel.toMap());
    return null;
  }
}

class RemoveStudentDocStudentAction extends ReduxAction<AppState> {
  final String userId;

  RemoveStudentDocStudentAction({required this.userId});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    StudentModel studentModel =
        StudentState.selectStudentOfCourse(state, userId)!;
    firebaseFirestore
        .collection(StudentModel.collection)
        .doc(studentModel.id)
        .delete();
    return null;
  }

  void after() {
    dispatch(ReadDocsStudentOfCourseStudentAction());
  }
}

class SelectStudentAndUserStudentAction extends ReduxAction<AppState> {
  final String userId;

  SelectStudentAndUserStudentAction({required this.userId});
  @override
  AppState reduce() {
    StudentModel studentModel =
        StudentState.selectStudentOfCourse(state, userId)!;
    UserModel userModel = StudentState.selectUsertOfCourse(state, userId)!;
    return state.copyWith(
      studentState: state.studentState
          .copyWith(studentCurrent: studentModel, user: userModel),
    );
  }
}

class UpdateModuleOfStudent extends ReduxAction<AppState> {
  final String moduleId;

  UpdateModuleOfStudent({required this.moduleId});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(StudentModel.collection)
        .doc(state.studentState.studentCurrent!.id);
    bool isModuleOfStudent = false;
    isModuleOfStudent =
        state.studentState.studentCurrent!.resourceMap.containsKey(moduleId);
    Map<String, List<String>>? resourceMap =
        state.studentState.studentCurrent!.resourceMap;

    Map<String, List<String>>? situationMap =
        state.studentState.studentCurrent!.situationMap;

    if (isModuleOfStudent) {
      resourceMap.remove(moduleId);
      situationMap.remove(moduleId);
    } else {
      resourceMap.addAll({moduleId: []});
      situationMap.addAll({moduleId: []});
    }
    await docRef.update({'resourceMap': resourceMap});
    await docRef.update({'situationMap': situationMap});
    return null;
  }

  void after() {
    dispatch(UpdateStudentCurrentStudentAction());
  }
}

class UpdateStudentCurrentStudentAction extends ReduxAction<AppState> {
  UpdateStudentCurrentStudentAction();
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    var a = await firebaseFirestore
        .collection(StudentModel.collection)
        .doc(state.studentState.studentCurrent!.id)
        .get();
    StudentModel studentModel = StudentModel.fromMap(a.id, a.data()!);

    return state.copyWith(
      studentState: state.studentState.copyWith(
        studentCurrent: studentModel,
      ),
    );
  }
}


// class SetTeacherCurrentTeacherAction extends ReduxAction<AppState> {
//   final String? id;
//   SetTeacherCurrentTeacherAction({
//     required this.id,
//   });
//   @override
//   AppState? reduce() {
//     print('--> SetTeacherCurrentTeacherAction $id');
//     UserModel? userModel;
//     if (id != null && id!.isNotEmpty) {
//       userModel = state.teacherState.teacherList!
//           .firstWhereOrNull((element) => element.id == id);
//       if (userModel != null) {
//         return state.copyWith(
//           teacherState: state.teacherState.copyWith(
//             teacherCurrent: userModel,
//           ),
//         );
//       }
//     }
//     return state.copyWith(
//       teacherState: state.teacherState.copyWith(
//         teacherCurrentNull: true,
//       ),
//     );
//   }
// }
