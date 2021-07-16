import 'package:administracao/app_state.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/foundation.dart';

class TeamState {
  final UserModel? person;
  final List<UserModel>? people;
  static UserModel selectPerson(AppState state, String personId) =>
      state.teamState.people!.firstWhere((element) => element.id == personId);
  // static UserModel sorted(AppState state) =>
  //     state.teamState.people!.sort((a,b)=>a.displayName.compareTo(b.displayName));

  TeamState({
    this.person,
    this.people,
  });
  factory TeamState.initialState() => TeamState(
        person: null,
        people: [],
      );

  TeamState copyWith({
    UserModel? person,
    bool personNull = false,
    List<UserModel>? people,
  }) {
    return TeamState(
      person: personNull ? null : person ?? this.person,
      people: people ?? this.people,
    );
  }

  @override
  String toString() => 'PersonState(person: $person, people: $people)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamState &&
        other.person == person &&
        listEquals(other.people, people);
  }

  @override
  int get hashCode => person.hashCode ^ people.hashCode;
}
