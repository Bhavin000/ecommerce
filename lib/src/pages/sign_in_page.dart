import 'package:ecommerce/src/data/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final FirebaseRepo firebaseRepo = FirebaseRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign in with google'),
          onPressed: () async {
            final result = await firebaseRepo.googleSignIn();

            if (result) {
              Navigator.of(context).popAndPushNamed('/homeScreen');
            } else {
              Navigator.of(context).popAndPushNamed('/signInPage');
            }
          },
        ),
      ),
    );
  }
}
