import 'package:administracao/user/user_action.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:administracao/app_state.dart';
import 'package:administracao/team/team_action.dart';
import 'package:administracao/team/team_page.dart';
import 'package:administracao/team/team_state.dart';
import 'package:administracao/user/user_model.dart';

class TeamPageConnector extends StatelessWidget {
  const TeamPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeamPageViewModel>(
      vm: () => TeamPageViewModelFactory(this),
      onInit: (store) => store.dispatch(StreamDocsTeamAction()),
      builder: (context, vm) => TeamPage(
        people: vm.people,
        countCoordinator: vm.countCoordinator,
        countAdministrator: vm.countAdministrator,
        countStudent: vm.countStudent,
        countTeacher: vm.countTeacher,
        countAll: vm.countAll,
        setPeopleInApp: vm.setPeopleInApp,
        peopleInApp: vm.peopleInApp,
        updatePersonInApp: vm.updatePersonInApp,
      ),
    );
  }
}

class TeamPageViewModelFactory extends VmFactory<AppState, TeamPageConnector> {
  TeamPageViewModelFactory(widget) : super(widget);
  @override
  TeamPageViewModel fromStore() => TeamPageViewModel(
        // people: state.teamState.people!,
        people: TeamState.peopleOnApp(state)!,
        countCoordinator:
            TeamState.countPersonInApp(state, PeopleInApp.coordinator),
        countTeacher: TeamState.countPersonInApp(state, PeopleInApp.teacher),
        countAdministrator:
            TeamState.countPersonInApp(state, PeopleInApp.administrator),
        countStudent: TeamState.countPersonInApp(state, PeopleInApp.student),
        countAll: TeamState.countPersonInApp(state, PeopleInApp.all),
        peopleInApp: state.teamState.peopleInApp,
        setPeopleInApp: (PeopleInApp peopleInApp) {
          print('setPeopleInApp');
          dispatch(SetPeopleInAppTeamAction(peopleInApp: peopleInApp));
        },
        updatePersonInApp: (String userId, String app, bool isUnionOrRemove) {
          dispatch(UpdateAppListUserAction(
            userId: userId,
            app: app,
            isUnionOrRemove: isUnionOrRemove,
          ));
        },
      );
}

class TeamPageViewModel extends Vm {
  final List<UserModel> people;
  final String countCoordinator;
  final String countTeacher;
  final String countAdministrator;
  final String countStudent;
  final String countAll;
  final PeopleInApp peopleInApp;
  final Function(PeopleInApp) setPeopleInApp;
  final Function(String, String, bool) updatePersonInApp;
  TeamPageViewModel({
    required this.people,
    required this.countCoordinator,
    required this.countTeacher,
    required this.countAdministrator,
    required this.countStudent,
    required this.countAll,
    required this.setPeopleInApp,
    required this.peopleInApp,
    required this.updatePersonInApp,
  }) : super(equals: [
          people,
          countCoordinator,
          countTeacher,
          countAdministrator,
          countStudent,
          countAll,
          peopleInApp,
        ]);
}
