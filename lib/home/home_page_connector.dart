import 'package:async_redux/async_redux.dart';
import 'package:administracao/app_state.dart';
import 'package:administracao/home/home_page.dart';
import 'package:administracao/login/login_action.dart';

import 'package:flutter/material.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      builder: (context, vm) => HomePage(
        signOut: vm.signOut,
        photoUrl: vm.photoUrl,
        phoneNumber: vm.phoneNumber,
        displayName: vm.displayName,
        uid: vm.uid,
        id: vm.id,
        email: vm.email,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        signOut: () => dispatch(SignOutLoginAction()),
        photoUrl: state.userState.userCurrent!.photoURL ?? '',
        phoneNumber: state.userState.userCurrent!.phoneNumber ?? '',
        displayName: state.userState.userCurrent!.displayName ?? '',
        email: state.userState.userCurrent!.email,
        uid: state.loginState.userFirebaseAuth?.uid ?? '',
        id: state.userState.userCurrent!.id,
      );
}

class HomeViewModel extends Vm {
  final VoidCallback signOut;

  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final String email;
  final String uid;
  final String id;
  HomeViewModel({
    required this.signOut,
    required this.photoUrl,
    required this.phoneNumber,
    required this.displayName,
    required this.email,
    required this.uid,
    required this.id,
  }) : super(
          equals: [
            photoUrl,
            phoneNumber,
            displayName,
            email,
            uid,
            id,
          ],
        );
}
