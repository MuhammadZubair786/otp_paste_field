// ignore_for_file: use_build_context_synchronously

library otp_paste_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that displays a field for entering OTP (One-Time Password).
/// It allows users to type or paste the OTP code. The widget is fully customizable for appearance,
/// such as background color, border color, text color, and more.
/// Ideal for authentication screens in mobile apps.
class OtpFieldView extends StatefulWidget {
  /// The number of OTP digits.
  /// Default is 6 digits.
  final int otpLength;

  /// The border radius for each OTP input field.
  /// Default is 10.0.
  final double borderRadius;

  /// The width of each OTP input field.
  /// Default is 45.0.
  final double fieldWidth;

  /// The height of each OTP input field.
  /// Default is 55.0.
  final double fieldHeight;

  /// The color of the border for each OTP input field.
  /// Default is [Colors.blue].
  final Color borderColor;

  /// The background color for each OTP input field.
  /// Default is [Colors.white].
  final Color backgroundColor;

  /// The color of the text entered in the OTP fields.
  /// Default is [Colors.blue].
  final Color textColor;

  /// The color of the border when the OTP input field is focused.
  /// Default is [Colors.blue].
  final Color focusedBorderColor;

  /// Creates an OTP field view with the specified properties.
  const OtpFieldView({
    super.key,
    this.otpLength = 6,
    this.borderRadius = 10.0,
    this.fieldWidth = 45.0,
    this.fieldHeight = 55.0,
    this.borderColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.blue,
    this.focusedBorderColor = Colors.blue,
  });

  @override
  State<OtpFieldView> createState() => _OtpFieldViewState();
}

/// The state of the [OtpFieldView] widget.
/// It manages the input and focus of each OTP field and handles pasting OTP code.
class _OtpFieldViewState extends State<OtpFieldView> {
  /// The current OTP code entered by the user.
  String otpCode = "";

  /// List of controllers for each OTP input field.
  List<TextEditingController> _controllers = [];

  /// List of focus nodes for each OTP input field.
  List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.otpLength, (_) => TextEditingController());
    _focusNodes = List.generate(widget.otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  /// Handles pasting an OTP code from the clipboard into the OTP fields.
  /// If the OTP length matches, it fills the OTP fields accordingly.
  Future<void> _handlePaste() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      String otp = clipboardData.text!.trim();

      if (otp.length == widget.otpLength) {
        for (int i = 0; i < widget.otpLength; i++) {
          _controllers[i].text = otp[i];
        }
        await Clipboard.setData(const ClipboardData(text: ''));
        FocusScope.of(context).requestFocus(_focusNodes[widget.otpLength - 1]);
        otpCode = otp;
      } else {
        FocusScope.of(context).requestFocus(_focusNodes[1]);
      }
    } else {
      FocusScope.of(context).requestFocus(_focusNodes[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.otpLength, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(
            width: widget.fieldWidth,
            height: widget.fieldHeight,
            child: TextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  counterText: "",
                  filled: true,
                  fillColor: widget.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.borderColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    borderSide: BorderSide(
                      color: widget.focusedBorderColor,
                      width: 1.5,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) async {
                  if (index == 0 && value.isNotEmpty) {
                    // Handle paste event
                    _handlePaste();
                  } else if (value.length == 1) {
                    // If a single character is entered, move to the next field
                    if (index < widget.otpLength - 1) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index + 1]);
                    } else {
                      FocusScope.of(context)
                          .unfocus(); // Unfocus if it's the last field
                    }
                  } else if (value.isEmpty || index > 0) {
                    if (index != 0) {
                      FocusScope.of(context)
                          .requestFocus(_focusNodes[index - 1]);
                    }
                    // If the field is cleared, move to the previous field
                  }
                }),
          ),
        );
      }),
    );
  }
}
