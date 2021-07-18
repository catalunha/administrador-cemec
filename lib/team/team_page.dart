import 'package:administracao/team/team_state.dart';
import 'package:flutter/material.dart';

import 'package:administracao/team/person_card.dart';
import 'package:administracao/user/user_model.dart';

class TeamPage extends StatelessWidget {
  final List<UserModel> people;
  final String countCoordinator;
  final String countTeacher;
  final String countAdministrator;
  final String countStudent;
  final String countAll;
  final Function(PeopleInApp) setPeopleInApp;
  final PeopleInApp peopleInApp;
  final Function(String, String, bool) updatePersonInApp;

  const TeamPage({
    Key? key,
    required this.people,
    required this.countCoordinator,
    required this.countTeacher,
    required this.countAdministrator,
    required this.countStudent,
    required this.countAll,
    required this.setPeopleInApp,
    required this.peopleInApp,
    required this.updatePersonInApp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sua equipe'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Wrap(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(countAll),
                    IconButton(
                      padding: EdgeInsets.only(top: 10),
                      onPressed: () {
                        setPeopleInApp(PeopleInApp.all);
                      },
                      icon: Icon(Icons.people),
                      color: peopleInApp.name == 'all'
                          ? Colors.yellow
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(countCoordinator),
                    IconButton(
                      padding: EdgeInsets.only(top: 10),
                      onPressed: () {
                        setPeopleInApp(PeopleInApp.coordinator);
                      },
                      icon: Icon(Icons.folder_shared_outlined),
                      color: peopleInApp.name == 'coordinator'
                          ? Colors.yellow
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(countTeacher),
                    IconButton(
                      padding: EdgeInsets.only(top: 10),
                      onPressed: () {
                        setPeopleInApp(PeopleInApp.teacher);
                      },
                      icon: Icon(Icons.assignment_ind_outlined),
                      color: peopleInApp.name == 'teacher'
                          ? Colors.yellow
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(countAdministrator),
                    IconButton(
                      padding: EdgeInsets.only(top: 10),
                      onPressed: () {
                        setPeopleInApp(PeopleInApp.administrator);
                      },
                      icon: Icon(Icons.manage_accounts_outlined),
                      color: peopleInApp.name == 'administrator'
                          ? Colors.yellow
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Text(countStudent),
                    IconButton(
                      padding: EdgeInsets.only(top: 10),
                      onPressed: () {
                        setPeopleInApp(PeopleInApp.student);
                      },
                      icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                      color: peopleInApp.name == 'student'
                          ? Colors.yellow
                          : Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),

                // IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.assignment_ind_outlined),
                // ),
                // IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.manage_accounts_outlined),
                // ),
                // IconButton(
                //   onPressed: null,
                //   icon: Icon(Icons.sentiment_satisfied_alt_outlined),
                // ),
              ],
            ),
          ),
          // Expanded(
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Expanded(
          //         flex: 1,
          //         child: Icon(
          //           Icons.search,
          //           // color: Colors.black45,
          //         ),
          //       ),
          //       Expanded(
          //         flex: 10,
          //         child: TextField(

          //           enabled: false,
          //           decoration: InputDecoration(
          //               // prefix: Icon(Icons.search),
          //               // border: InputBorder(borderSide: ),
          //               ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(height: 10),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: people
                    .map((e) => PersonCard(
                          person: e,
                          updatePersonInApp: updatePersonInApp,
                        ))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
