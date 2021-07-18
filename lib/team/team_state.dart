import 'package:administracao/app_state.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/foundation.dart';

enum PeopleInApp { all, coordinator, teacher, administrator, student }

extension PeopleAppExtension on PeopleInApp {
  static const names = {
    PeopleInApp.all: 'all',
    PeopleInApp.coordinator: 'coordinator',
    PeopleInApp.teacher: 'teacher',
    PeopleInApp.administrator: 'administrator',
    PeopleInApp.student: 'student',
  };
  String get name => names[this]!;
}

class TeamState {
  final UserModel? person;
  final List<UserModel>? people;
  final PeopleInApp peopleInApp;

  static UserModel selectPerson(AppState state, String personId) =>
      state.teamState.people!.firstWhere((element) => element.id == personId);

  static List<UserModel>? peopleOnApp(AppState state) {
    print('peopleOnApp1: ${state.teamState.peopleInApp}');
    if (state.teamState.peopleInApp == PeopleInApp.all) {
      print('peopleOnApp2');

      return state.teamState.people;
    } else {
      print('peopleOnApp3');
      return state.teamState.people!
          .where((element) =>
              element.appList.contains(state.teamState.peopleInApp.name))
          .toList();
    }
  }

  static String countPersonInApp(AppState state, PeopleInApp peopleInApp) {
    print('countPersonInApp 1: ${state.teamState.peopleInApp}');
    if (peopleInApp == PeopleInApp.all) {
      return '${state.teamState.people!.length}';
    }
    int count = 0;
    state.teamState.people!.forEach((element) {
      if (element.appList.contains(peopleInApp.name)) {
        count += 1;
      }
    });
    return '$count';
  }

  TeamState({
    this.person,
    this.people,
    required this.peopleInApp,
  });
  factory TeamState.initialState() => TeamState(
        person: null,
        people: [],
        peopleInApp: PeopleInApp.all,
      );

  TeamState copyWith({
    UserModel? person,
    bool personNull = false,
    List<UserModel>? people,
    PeopleInApp? peopleInApp,
  }) {
    return TeamState(
      person: personNull ? null : person ?? this.person,
      people: people ?? this.people,
      peopleInApp: peopleInApp ?? this.peopleInApp,
    );
  }

  @override
  String toString() => 'PersonState(person: $person, people: $people)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamState &&
        other.person == person &&
        other.peopleInApp == peopleInApp &&
        listEquals(other.people, people);
  }

  @override
  int get hashCode => person.hashCode ^ peopleInApp.hashCode ^ people.hashCode;
}
