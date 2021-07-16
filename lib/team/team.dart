import 'package:administracao/team/person_card.dart';
import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class Team extends StatelessWidget {
  final List<UserModel> people;

  const Team({
    Key? key,
    required this.people,
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
          Expanded(
            child: Wrap(
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
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Icon(Icons.search),
                ),
                Expanded(
                  flex: 10,
                  child: TextField(
                    decoration: InputDecoration(
                        // prefix: Icon(Icons.search),
                        // border: InputBorder(borderSide: ),
                        ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            flex: 15,
            child: SingleChildScrollView(
              child: Column(
                children: people
                    .map((e) => PersonCard(
                          person: e,
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
