import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  static const String routeName = '/verification';

  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? currentUser;
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    currentUser = _auth.currentUser;
    sendVerificationEmail();
  }

  Future<void> sendVerificationEmail() async {
    if (currentUser != null && !currentUser!.emailVerified) {
      try {
        setState(() {
          isVerifying = true;
        });
        await currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification email sent to ${currentUser!.email}'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending email: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          isVerifying = false;
        });
      }
    }
  }

  Future<void> checkVerificationStatus() async {
    try {
      await currentUser?.reload();
      setState(() {
        currentUser = _auth.currentUser;
      });

      if (currentUser!.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VerifiedHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email not verified yet.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              currentUser?.emailVerified == true
                  ? Icons.verified
                  : Icons.email_outlined,
              size: 80,
              color: currentUser?.emailVerified == true
                  ? Colors.green
                  : Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              currentUser?.emailVerified == true
                  ? 'Your email is verified!'
                  : 'Please verify your email.',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            if (!currentUser!.emailVerified)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: isVerifying ? null : sendVerificationEmail,
                    child: Text(isVerifying
                        ? 'Sending...'
                        : 'Resend Verification Email'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: checkVerificationStatus,
                    child: const Text('Check Verification Status'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class VerifiedHomePage extends StatelessWidget {
  const VerifiedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verified Home Page')),
      body: const Center(
        child: Text(
          'Welcome! Your email has been verified.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
