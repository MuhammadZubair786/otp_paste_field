library otp_paste_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpPasteField extends StatefulWidget {
  final int otpLength;
  final ValueChanged<String>? onCompleted;

   OtpPasteField({super.key, this.otpLength = 6, this.onCompleted});

  @override
  _OtpPasteFieldState createState() => _OtpPasteFieldState();
}

class _OtpPasteFieldState extends State<OtpPasteField> {
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      widget.otpLength,
      (index) => TextEditingController(),
    );
  }

  Future<void> _handlePaste() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      String otp = clipboardData.text!.trim();
      if (otp.length == widget.otpLength) {
        for (int i = 0; i < widget.otpLength; i++) {
          _controllers[i].text = otp[i];
        }
        widget.onCompleted?.call(otp);
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.otpLength, (index) {
        return SizedBox(
          width: 50,
          child: TextField(
            controller: _controllers[index],
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade600),
            decoration: InputDecoration(
              counterText: "",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) async {
              if (index == 0 && value.isNotEmpty) {
                _handlePaste();
              }
            },
          ),
        );
      }),
    );
  }
}
