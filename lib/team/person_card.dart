import 'package:administracao/team/person_tile.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class PersonCard extends StatelessWidget {
  final UserModel? person;

  const PersonCard({Key? key, this.person}) : super(key: key);

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
                onPressed: null,
                icon: Icon(Icons.folder_shared_outlined),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.assignment_ind_outlined),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.manage_accounts_outlined),
              ),
              IconButton(
                onPressed: null,
                icon: Icon(Icons.sentiment_satisfied_alt_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
