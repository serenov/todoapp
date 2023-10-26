import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todoapp/utils/api_services.dart';

class OTPScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final String email;

  OTPScreen({super.key, required this.email});

  void handleOTPVerification() async {
    final otp = otpController.text;
    const endpoint = '/api/auth/verify'; 
    final requestBody = {
      "email": email,
      "otp": otp,
    };

    try {
      String? res = await sendPostRequest(requestBody, endpoint);

      if (kDebugMode) {
        print(res);
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'Enter OTP',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleOTPVerification,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
