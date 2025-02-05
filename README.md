I understand that you want everything to be included in the `README.md` file, with all the details provided earlier. Here's the complete `README.md` file including all aspects:

```markdown

A Flutter package for rendering an OTP (One Time Password) input field where users can paste or type the OTP across multiple input fields. This package provides a customizable solution for OTP input forms.

 Description

The `otp_paste_field` package allows you to easily implement an OTP input field in your Flutter app. It provides a customizable OTP input field with support for multiple OTP fields. This widget is useful for apps that require OTP verification, such as login or registration processes.

 Features:

- **Customizable OTP Length:** Define the length of the OTP.
- **Support for Paste:** OTP can be pasted directly into the fields.
- **Easy Integration:** Can be easily integrated into any Flutter app.

Getting Started

Follow these steps to get started with `otp_paste_field` in your Flutter project.

Installation

To use this package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  otp_paste_field: ^1.0.0
```

### Usage

To use the OTP input field, import the package and implement the widget in your app:

```dart
import 'package:otp_paste_field/otp_paste_field.dart';

OtpFieldView(
  otpLength: 6,  // Set OTP length
  borderRadius: 10.0,  // Border radius for each OTP field
  fieldWidth: 50.0,  // Width of each OTP field
  fieldHeight: 50.0,  // Height of each OTP field
  borderColor: Colors.grey,  // Border color of the OTP fields
  backgroundColor: Colors.white,  // Background color of OTP fields
  textColor: Colors.black,  // Text color inside the OTP fields
  focusedBorderColor: Colors.blue,  // Border color when focused
)
```

### Properties

| Property               | Type    | Description                                                    |
|------------------------|---------|----------------------------------------------------------------|
| `otpLength`            | int     | Defines the length of the OTP input.                          |
| `borderRadius`         | double  | Sets the border radius of input fields.                       |
| `fieldWidth`           | double  | Width of each OTP input field.                                |
| `fieldHeight`          | double  | Height of each OTP input field.                               |
| `borderColor`          | Color   | Color of the border for input fields.                         |
| `backgroundColor`      | Color   | Background color of the input fields.                         |
| `textColor`            | Color   | Color of the text inside the input fields.                    |
| `focusedBorderColor`   | Color   | Border color when the field is focused.                       |

### Example

```dart
import 'package:flutter/material.dart';
import 'package:otp_paste_field/otp_paste_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('OTP Paste Field Example')),
        body: Center(
          child: OtpFieldView(
        borderRadius: 20,
        focusedBorderColor: Color.fromARGB(255, 3, 34, 136),
        borderColor: Color.fromARGB(255, 3, 34, 136),
        otpLength: 6,
      ))
      ),
    );
  }
}
```

### Output

Here is a preview of the OTP input field in action:

![OTP Paste Field Demo](https://s5.ezgif.com/tmp/ezgif-5e6e368f2cad9.gif)

### Customization

The widget allows full customization to fit your design preferences. You can modify:
- The length of the OTP.
- The appearance of input fields, including border radius, width, height, and colors.
- The behavior when a user focuses on an OTP field (focused border color).
- Support for pasting OTP directly into the fields, making it more user-friendly.

## Contributing

Feel free to open an issue or submit a pull request if you have any improvements, suggestions, or fixes!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

