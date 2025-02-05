import 'package:flutter/material.dart';
import 'package:otp_test/otp_field.dart';
// Import your OtpPasteField file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OTP Paste Field Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: const Card(
                elevation: 10,
                child: Center(
                    child: Text(
                  'OTP Paste Field Demo ',
                  style: TextStyle(
                      color: Color.fromARGB(255, 3, 34, 136),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ))),
          )),
      body: const Center(
          child: OtpFieldView(
        borderRadius: 20,
        focusedBorderColor: Color.fromARGB(255, 3, 34, 136),
        borderColor: Color.fromARGB(255, 3, 34, 136),
        otpLength: 6,
      )),
    );
  }
}
