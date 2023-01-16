import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:melee_notes/pages/login_or_register_page.dart';
import 'home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 1100) {
                      return Center(
                          child: SizedBox(
                        width: constraints.maxWidth / 2,
                        child: const LoginOrRegisterPage(),
                      ));
                    } else {
                      return const LoginOrRegisterPage();
                    }
                  },
                );
              }
            }));
  }
}
