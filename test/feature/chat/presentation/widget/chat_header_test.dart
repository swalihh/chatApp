import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_screen_widgets/chat_header.dart';

void main() {
  testWidgets('AppHeader displays connection status', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppHeader(),
        ),
      ),
    );

    expect(find.textContaining("Connected"), findsOneWidget);
  });
}
