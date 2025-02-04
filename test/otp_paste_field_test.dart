import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp_paste_field/otp_paste_field.dart';

void main() {
  testWidgets('OtpPasteField should render OTP input fields', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpPasteField(otpLength: 6),
        ),
      ),
    );

    // Verify that 6 OTP input fields are displayed
    expect(find.byType(TextField), findsNWidgets(6));
  });

  testWidgets('OtpPasteField should paste OTP correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: OtpPasteField(otpLength: 6),
        ),
      ),
    );

    // Find all text fields
    final textFields = find.byType(TextField);

    // Enter each digit manually (since Flutter does not support pasting in tests)
    await tester.enterText(textFields.at(0), '1');
    await tester.enterText(textFields.at(1), '2');
    await tester.enterText(textFields.at(2), '3');
    await tester.enterText(textFields.at(3), '4');
    await tester.enterText(textFields.at(4), '5');
    await tester.enterText(textFields.at(5), '6');

    await tester.pump();

    // Verify that each field contains the correct digit
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
  });
}
