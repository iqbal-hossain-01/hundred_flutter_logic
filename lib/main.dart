import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hundred_flutter_logic/core/widgets/home_page_item_view.dart';
import 'package:hundred_flutter_logic/features/api_logic/dummyjson_app/dummy_json_app.dart';
import 'package:hundred_flutter_logic/features/api_logic/dummyjson_app/dummy_json_app_details.dart';
import 'package:hundred_flutter_logic/features/api_logic/dummyjson_app/dummyjson_home.dart';
import 'package:hundred_flutter_logic/features/api_logic/pages/api_show_result_page.dart';
import 'package:hundred_flutter_logic/features/api_logic/pages/create_post_page.dart';
import 'package:hundred_flutter_logic/features/api_logic/pages/pagination_page.dart';
import 'package:hundred_flutter_logic/features/api_logic/provider/product_provider.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/email_verification_page.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/login_logic.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/otp_verification_page.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/password_reset_logic.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/session_management_page.dart';
import 'package:hundred_flutter_logic/features/auth_logic/pages/signin_logic.dart';
import 'package:hundred_flutter_logic/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider(),)
      ],
      child: const MyApp(),
    ),
  );
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
        SessionManagementPage.routeName: (context) =>
            const SessionManagementPage(),
        MyHomePage.routeName: (context) => const MyHomePage(),
        LoginLogic.routeName: (context) => const LoginLogic(),
        SignInLogic.routeName: (context) => const SignInLogic(),
        PasswordResetLogic.routeName: (context) => const PasswordResetLogic(),
        EmailVerificationPage.routeName: (context) =>
            const EmailVerificationPage(),
        OtpVerificationPage.routeName: (context) => const OtpVerificationPage(),
        ApiShowResultPage.routeName: (context) => const ApiShowResultPage(),
        CreatePostPage.routeName: (context) => const CreatePostPage(),
        PaginationPage.routeName: (context) => const PaginationPage(),
        DummyJsonApp.routeName: (context) => const DummyJsonApp(),

        /*
        // Other page but not using NamedRouting:
        //DummyJsonHome.routeName: (context) => const DummyJsonHome(),
        // AddProductPage()
        // DummyJsonAppDetails()
         */
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String routeName = '/home';

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
            title: 'Go to SignIn Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, PasswordResetLogic.routeName);
            },
            title: 'Go to Password Reset Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, SessionManagementPage.routeName);
            },
            title: 'Go to Session Management Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, EmailVerificationPage.routeName);
            },
            title: 'Go to email verification Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, OtpVerificationPage.routeName);
            },
            title: 'Go to OTP verification Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, ApiShowResultPage.routeName);
            },
            title: 'Go to Api Get Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, CreatePostPage.routeName);
            },
            title: 'Go to Post_Put_Delete Page',
          ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, PaginationPage.routeName);
            },
            title: 'Go to Pagination Page',
          ),
          // HomePageItemView(
          //   routeName: () {
          //     Navigator.pushNamed(context, DummyJsonHome.routeName);
          //   },
          //   title: 'Go to DummyJsonApi Page',
          // ),
          HomePageItemView(
            routeName: () {
              Navigator.pushNamed(context, DummyJsonApp.routeName);
            },
            title: 'Go to DummyJson App',
          ),
        ],
      ),
    );
  }
}
