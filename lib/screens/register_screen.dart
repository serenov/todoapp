// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapp/screens/otp_screen.dart';
import 'package:todoapp/utils/api_services.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscureText = false;

  void _handleRegistration() async {
    final email = emailController.text;
    final password = passwordController.text;

    const endpoint = '/api/auth/register'; 
    final requestBody = {
      "email": email,
      "password": password,
    };

    try {
      String? res = await sendPostRequest(requestBody, endpoint);
      if (kDebugMode) {
        print(res);
      }

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => OTPScreen(email: email),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail, size: 24),
              ),
            ),
            TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_rounded, size: 24),
                  suffixIcon: IconButton(
                      onPressed: togglePasswordVisibility,
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility))),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleRegistration,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  // void _togglePassowrdVisibility() {
  //   _passwordVisible = _passwordVisible? false: true;
  // }
}
