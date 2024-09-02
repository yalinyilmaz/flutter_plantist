
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/app/bloc/app_bloc.dart';
import 'package:flutter_plantist_app/app/components/custom_buttons/custom_elevated_button.dart';
import 'package:flutter_plantist_app/features/authentication/model/auth_status_model.dart';


class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
            const SizedBox(height: 20),
            StreamBuilder<AuthStatus>(
              stream: appBloc.authStatus,
              initialData: FirebaseAuth.instance.currentUser != null
                  ? AuthStatusLoggedIn(userEmail: FirebaseAuth.instance.currentUser!.email!)
                  : const AuthStatusLoggedOut(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final authStatus = snapshot.requireData;
                  if(authStatus is AuthStatusLoggedIn){
                    return Text(
                        authStatus.userEmail,
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                  }else{
                    return const SizedBox();
                  }
                } else {
                  return const Text('Loading...');
                }
              },
            ),
            const Spacer(),
            CustomElevatedButton(
              onButtonPressed: (p0) {
                appBloc.logout();
              },
              isPrimary: false,
              text: "Logout",
            ),
              const SizedBox(
                height: 5,
              ),
              CustomElevatedButton(
                onButtonPressed: (p0) {
                  appBloc.deleteAccount();
                },
                isPrimary: false,
                text: "Delete Account",
              )
            ],
          )),
    );
  }
}
