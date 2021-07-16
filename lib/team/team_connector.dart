import 'package:administracao/app_state.dart';
import 'package:administracao/team/team.dart';
import 'package:administracao/team/team_action.dart';
import 'package:administracao/user/user_model.dart';
import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

class TeamConnector extends StatelessWidget {
  const TeamConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeamViewModel>(
      vm: () => TeamViewModelFactory(this),
      onInit: (store) => store.dispatch(StreamDocsTeamAction()),
      builder: (context, vm) => Team(
        people: vm.people,
      ),
    );
  }
}

class TeamViewModelFactory extends VmFactory<AppState, TeamConnector> {
  TeamViewModelFactory(widget) : super(widget);
  @override
  TeamViewModel fromStore() => TeamViewModel(
        people: state.teamState.people!,
      );
}

class TeamViewModel extends Vm {
  final List<UserModel> people;
  TeamViewModel({
    required this.people,
  }) : super(equals: [
          people,
        ]);
}
