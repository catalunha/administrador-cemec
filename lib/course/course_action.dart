import 'package:administracao/coordinator/coordinator_action.dart';
import 'package:administracao/course/course_state.dart';
import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:administracao/app_state.dart';
import 'package:administracao/coordinator/coordinator_state.dart';
import 'package:administracao/course/course_model.dart';
import 'package:administracao/teacher/teacher_state.dart';
import 'package:administracao/user/user_model.dart';

class StreamDocsCourseAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsCourseAction 1');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(CourseModel.collection)
        // .where('coordinatorUserId', isEqualTo: state.userState.userCurrent!.id)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<CourseModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                CourseModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<CourseModel> courseList) {
      print('--> StreamDocsCourseAction 2');
      // dispatch(SetCourseListCourseAction(courseList: courseList));
      dispatch(StreamCascadeCourseAction(courseList: courseList));
    });
    // BillState.billStream = streamList.listen((List<BillModel> billModelList) {
    //   dispatch(SetBillListBillAction(billModelList: billModelList));
    // });

    return null;
  }
}

class StreamCascadeCourseAction extends ReduxAction<AppState> {
  final List<CourseModel> courseList;

  StreamCascadeCourseAction({required this.courseList});
  @override
  Future<AppState?> reduce() async {
    await dispatch(SetCourseListCourseAction(courseList: courseList));
    if (state.courseState.course != null) {
      dispatch(SetCourseCourseAction(id: state.courseState.course!.id));
    }
    dispatch(GetCoordinatorListOfCourseListCourseAction());
    return null;
  }
}

class SetCourseListCourseAction extends ReduxAction<AppState> {
  final List<CourseModel> courseList;

  SetCourseListCourseAction({required this.courseList});
  @override
  AppState reduce() {
    return state.copyWith(
      courseState: state.courseState.copyWith(
        courseList: courseList,
      ),
    );
  }

  // void after() {
  //   if (state.courseState.course != null) {
  //     dispatch(SetCourseCourseAction(id: state.courseState.course!.id));
  //   }
  //   dispatch(GetCoordinatorListOfCourseListCourseAction());
  // }
}

class SetCourse1CourseAction extends ReduxAction<AppState> {
  final String id;
  SetCourse1CourseAction({
    required this.id,
  });
  @override
  AppState reduce() {
    print('--> SetCourseCurrentCourseAction $id');
    CourseModel courseModel = CourseModel(
      '',
      coordinatorUserId: '',
      title: '',
      description: '',
      syllabus: '',
      isArchivedByAdm: false,
      isArchivedByCoord: false,
      isDeleted: false,
      isActive: true,
    );
    if (id.isNotEmpty) {
      courseModel = state.courseState.courseList!
          .firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      courseState: state.courseState.copyWith(
        course: courseModel,
      ),
    );
  }

  // void after() async {
  //   if (id.isNotEmpty) {
  //     dispatch(SetCoordinatorCurrentCoordinatorAction(
  //         id: state.courseState.course!.coordinatorUserId));
  //     // await dispatch(GetCoordinatorOfCourseCourseAction(
  //     //     coordinatorId: state.courseState.course!.coordinatorUserId));
  //     await dispatch(GetDocsCollegiateCourseAction());
  //   }
  // }
}

class SetCourseCourseAction extends ReduxAction<AppState> {
  final String id;

  SetCourseCourseAction({required this.id});
  @override
  Future<AppState?> reduce() async {
    dispatch(SetCourse1CourseAction(id: id));
    if (id.isNotEmpty) {
      dispatch(SetCoordinatorCurrentCoordinatorAction(
          id: state.courseState.course!.coordinatorUserId));
      await dispatch(GetDocsCollegiateCourseAction());
    }
    return null;
  }
}

// class GetCoordinatorOfCourseCourseAction extends ReduxAction<AppState> {
//   final String coordinatorId;
//   GetCoordinatorOfCourseCourseAction({
//     required this.coordinatorId,
//   });
//   @override
//   Future<AppState> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     // state.copyWith(coordinatorState: CoordinatorState.initialState());
//     // List<UserModel> coordinatorList = [];

//     // for (CourseModel courseModel in state.courseState.courseModelList!) {
//     DocumentReference<Map<String, dynamic>> docRef =
//         firebaseFirestore.collection(UserModel.collection).doc(coordinatorId);
//     DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
//     UserModel userModel = UserModel.fromMap(doc.id, doc.data()!);
//     // if (!coordinatorList.contains(userModel)) {
//     //   coordinatorList.add(userModel);
//     // }
//     // }

//     // print(
//     //     '--> ReadDocCoordinatorOfModuleListModuleAction ${coordinatorList.length}');
//     return state.copyWith(
//       courseState: state.courseState.copyWith(
//         coordinator: userModel,
//       ),
//     );
//   }
// }

class GetDocsCollegiateCourseAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    state.copyWith(teacherState: TeacherState.initialState());
    List<UserModel> collegiate = [];
    if (state.courseState.course!.collegiate != null) {
      for (String userId in state.courseState.course!.collegiate!) {
        DocumentReference<Map<String, dynamic>> docRef =
            firebaseFirestore.collection(UserModel.collection).doc(userId);
        DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
        UserModel userModel = UserModel.fromMap(doc.id, doc.data()!);
        if (!collegiate.contains(userModel)) {
          collegiate.add(userModel);
        }
      }
    }
    print('--> ReadDocsCollegiateCourseAction ${collegiate.length}');
    return state.copyWith(
      courseState: state.courseState.copyWith(
        collegiate: collegiate,
      ),
    );
  }
}

class GetCoordinatorListOfCourseListCourseAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    state.copyWith(coordinatorState: CoordinatorState.initialState());
    List<UserModel> coordinatorList = [];

    for (CourseModel courseModel in state.courseState.courseList!) {
      DocumentReference<Map<String, dynamic>> docRef = firebaseFirestore
          .collection(UserModel.collection)
          .doc(courseModel.coordinatorUserId);
      DocumentSnapshot<Map<String, dynamic>> doc = await docRef.get();
      UserModel userModel = UserModel.fromMap(doc.id, doc.data()!);
      if (!coordinatorList.contains(userModel)) {
        coordinatorList.add(userModel);
      }
    }

    print(
        '--> ReadDocCoordinatorOfModuleListModuleAction ${coordinatorList.length}');
    return state.copyWith(
      coordinatorState: state.coordinatorState.copyWith(
        coordinatorList: coordinatorList,
      ),
    );
  }
}

class CreateDocCourseAction extends ReduxAction<AppState> {
  final CourseModel courseModel;

  CreateDocCourseAction({required this.courseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(CourseModel.collection).doc();
    await docRef.set(courseModel.toMap());
    return null;
  }
}

class UpdateDocCourseAction extends ReduxAction<AppState> {
  final CourseModel courseModel;

  UpdateDocCourseAction({required this.courseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(CourseModel.collection)
        .doc(courseModel.id);
    await docRef.update(courseModel.toMap());
    return null;
  }
}

class UpdateModuleOrderCourseAction extends ReduxAction<AppState> {
  final String id;
  final bool isUnionOrRemove;
  UpdateModuleOrderCourseAction({
    required this.id,
    required this.isUnionOrRemove,
  });
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(CourseModel.collection)
        .doc(state.courseState.course!.id);
    if (isUnionOrRemove) {
      await docRef.update({
        'moduleOrder': FieldValue.arrayUnion([id])
      });
    } else {
      await docRef.update({
        'moduleOrder': FieldValue.arrayRemove([id])
      });
    }
    return null;
  }
}

class UpdateTeacherInCollegiateCourseAction extends ReduxAction<AppState> {
  final String teacherId;
  final bool isUnionOrRemove;
  UpdateTeacherInCollegiateCourseAction({
    required this.teacherId,
    required this.isUnionOrRemove,
  });
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(CourseModel.collection)
        .doc(state.courseState.course!.id);
    if (isUnionOrRemove) {
      await docRef.update({
        'collegiate': FieldValue.arrayUnion([teacherId])
      });
    } else {
      await docRef.update({
        'collegiate': FieldValue.arrayRemove([teacherId])
      });
    }
    return null;
  }
}
