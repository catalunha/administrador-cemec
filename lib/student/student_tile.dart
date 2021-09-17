import 'package:administracao/theme/app_icon.dart';
import 'package:administracao/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final UserModel? user;
  const StudentTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user != null
        ? ListTile(
            leading: user!.photoURL == null
                ? Icon(AppIconData.undefined)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      user!.photoURL!,
                      height: 58,
                      width: 58,
                    ),
                  ),
            title: Text(user!.displayName ?? ''),
            subtitle: Text('email: ${user!.email}\nuserId: ${user!.id}'),
            trailing: Icon(AppIconData.student),
          )
        : ListTile(
            leading: Icon(
              AppIconData.undefined,
            ),
            title: Text('Estudante não disponivel'),
          );
  }
}
