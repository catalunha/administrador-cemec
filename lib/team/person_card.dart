import 'package:administracao/team/person_tile.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final UserModel? person;
  final Function(String, String, bool) updatePersonInApp;

  const PersonCard({Key? key, this.person, required this.updatePersonInApp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        children: [
          PersonTile(
            person: person,
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () {
                  if (person!.appList.contains('coordinator')) {
                    updatePersonInApp(person!.id, 'coordinator', false);
                  } else {
                    updatePersonInApp(person!.id, 'coordinator', true);
                  }
                },
                icon: Icon(
                  Icons.folder_shared_outlined,
                  color: person!.appList.contains('coordinator')
                      ? Colors.yellow
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (person!.appList.contains('teacher')) {
                    updatePersonInApp(person!.id, 'teacher', false);
                  } else {
                    updatePersonInApp(person!.id, 'teacher', true);
                  }
                },
                icon: Icon(
                  Icons.assignment_ind_outlined,
                  color: person!.appList.contains('teacher')
                      ? Colors.yellow
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (person!.appList.contains('administrator')) {
                    updatePersonInApp(person!.id, 'administrator', false);
                  } else {
                    updatePersonInApp(person!.id, 'administrator', true);
                  }
                },
                icon: Icon(
                  Icons.manage_accounts_outlined,
                  color: person!.appList.contains('administrator')
                      ? Colors.yellow
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (person!.appList.contains('student')) {
                    updatePersonInApp(person!.id, 'student', false);
                  } else {
                    updatePersonInApp(person!.id, 'student', true);
                  }
                },
                icon: Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: person!.appList.contains('student')
                      ? Colors.yellow
                      : Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
