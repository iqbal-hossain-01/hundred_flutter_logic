import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/core/widgets/home_page_item_view.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/login_logic.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/signin_logic.dart';
import 'package:hundred_flutter_logic/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hundred Logic App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName: (context) => const MyHomePage(),
        LoginLogic.routeName: (context) => const LoginLogic(),
        SignInLogic.routeName: (context) => const SignInLogic(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String routeName = '/';

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: const Text('Hundred Logic App'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, LoginLogic.routeName);
            },
            title: 'Go to Login Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, SignInLogic.routeName);
            },
            title: 'Go to SignIn   Page',
          ),
        ],
      ),
    );
  }
}
