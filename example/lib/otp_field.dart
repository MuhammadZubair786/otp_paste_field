import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpFieldView extends StatefulWidget {
  final int otpLength;
  final double borderRadius;
  final double fieldWidth;
  final double fieldHeight;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final Color focusedBorderColor;

  const OtpFieldView({
    super.key,
    this.otpLength = 6, // Default OTP length
    this.borderRadius = 10.0, // Default border radius
    this.fieldWidth = 45.0, // Default width
    this.fieldHeight = 55.0, // Default height
    this.borderColor = Colors.blue, // Default border color
    this.backgroundColor = Colors.white, // Default background color
    this.textColor = Colors.blue, // Default text color
    this.focusedBorderColor = Colors.blue, // Default focused border color
  });

  @override
  State<OtpFieldView> createState() => _OtpFieldViewState();
}

class _OtpFieldViewState extends State<OtpFieldView> {
  String otpCode = "";
  List<TextEditingController> _controllers = [];
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

  Future<void> _handlePaste() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      String otp = clipboardData.text!.trim();
      if (otp.length == widget.otpLength) {
        for (int i = 0; i < widget.otpLength; i++) {
          _controllers[i].text = otp[i];
        }
        FocusScope.of(context).unfocus(); // Unfocus after pasting
        await Clipboard.setData(const ClipboardData(text: ''));
        otpCode = otp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
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
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                            color: widget.borderColor,
                            width: 1.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                            color: widget.borderColor,
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          borderSide: BorderSide(
                            color: widget.focusedBorderColor,
                            width: 1.5,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) async {
                        if (index == 0 && value.length == 1) {
                          _handlePaste();
                        } else if (value.length == 1 &&
                            index < widget.otpLength - 1) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
