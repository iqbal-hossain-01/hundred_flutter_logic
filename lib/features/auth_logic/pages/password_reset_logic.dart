import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetLogic extends StatefulWidget {
  static const String routeName = '/resetPassword';
  const PasswordResetLogic({super.key});

  @override
  State<PasswordResetLogic> createState() => _PasswordResetLogicState();
}

class _PasswordResetLogicState extends State<PasswordResetLogic> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword() async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
          email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Password reset email sent to ${_emailController.text.trim()}'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('error: ${e.toString()}')));
    } finally {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetPassword,
              child: const Text('Send Reset Email'),
            ),
          ],
        ),
      ),
    );
  }
}
