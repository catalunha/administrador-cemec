import 'package:administracao/team/team_state.dart';
import 'package:administracao/user/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StreamDocsTeamAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsTeamAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore.collection(UserModel.collection);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<UserModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                UserModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<UserModel> userModelList) {
      dispatch(SetPeopleTeamAction(people: userModelList));
    });
    // BillState.billStream = streamList.listen((List<BillModel> billModelList) {
    //   dispatch(SetBillListBillAction(billModelList: billModelList));
    // });

    return null;
  }
}

class SetPeopleTeamAction extends ReduxAction<AppState> {
  final List<UserModel> people;

  SetPeopleTeamAction({required this.people});
  @override
  AppState reduce() {
    print('-->SetPeopleTeamAction ${people.length}');
    people.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    return state.copyWith(
      teamState: state.teamState.copyWith(
        people: people,
      ),
    );
  }

  void after() {
    if (state.teamState.person != null) {
      dispatch(SetPersonTeamAction(id: state.teamState.person!.id));
    }
  }
}

class SetPersonTeamAction extends ReduxAction<AppState> {
  final String? id;
  SetPersonTeamAction({
    required this.id,
  });
  @override
  AppState? reduce() {
    return state.copyWith(
      teamState: state.teamState.copyWith(
        person: TeamState.selectPerson(state, id!),
      ),
    );
  }
}

class SetPeopleInAppTeamAction extends ReduxAction<AppState> {
  final PeopleInApp peopleInApp;

  SetPeopleInAppTeamAction({required this.peopleInApp});
  @override
  AppState reduce() {
    return state.copyWith(
      teamState: state.teamState.copyWith(
        peopleInApp: peopleInApp,
      ),
    );
  }
}
