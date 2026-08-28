import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inbox/presentation/components/buttons/custom_button.dart';
import 'package:inbox/presentation/components/text_fields/custom_text_field.dart';

void main() {
  testWidgets('CustomButton tap in form', (WidgetTester tester) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => const MaterialApp(
          home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Form(
                    child: Column(
                      children: [
                        CustomTextField(),
                        CustomButton(onTap: null, text: 'Hi'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Hi'));
    await tester.pump();
  });
}
