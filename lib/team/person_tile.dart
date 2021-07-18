import 'package:administracao/user/user_model.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final UserModel? person;
  const PersonTile({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return person != null
        ? ListTile(
            leading: person!.photoURL == null
                ? Icon(Icons.person_pin_outlined)
                : Tooltip(
                    message: 'id: ${person!.id}',
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(person!.photoURL!),
                        ),
                      ),
                    ),
                  ),
            title: Text(person!.displayName ?? ''),
            subtitle: Text(
                'email: ${person!.email}\nMobile: ${person!.phoneNumber ?? ""}\n${person!.id}'),
          )
        : Container();
  }
}
