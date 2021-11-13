import 'package:ecommerce/src/data/repositories/firebase_repository.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  init(context) async {
    FirebaseRepo firebaseRepo = FirebaseRepo();

    final result = await firebaseRepo.checkSignedIn();
    if (result) {
      Navigator.of(context).popAndPushNamed('/homeScreen');
    } else {
      Navigator.of(context).popAndPushNamed('/signInPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Splash screen'),
        ),
      ),
    );
  }
}
