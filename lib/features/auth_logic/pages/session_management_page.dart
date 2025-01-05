import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/login_logic.dart';
import 'package:hundred_flutter_logic/main.dart';

class SessionManagementPage extends StatefulWidget {
  static const String routeName = '/session';

  const SessionManagementPage({super.key});

  @override
  State<SessionManagementPage> createState() => _SessionManagementPageState();
}

class _SessionManagementPageState extends State<SessionManagementPage> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> checkUserSession() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      Navigator.pushReplacementNamed(context, LoginLogic.routeName);
    } else {
      Navigator.pushReplacementNamed(context, MyHomePage.routeName);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(seconds: 0),
          () {
            checkUserSession();
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
