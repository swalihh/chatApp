import 'package:chat_app/features/chat/presentation/pages/individual_chat_screen.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_screen.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_screen_widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ChatScreen renders chat list and navigates on tap', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ChatScreen(),
      ),
    );

    // Check if the AppHeader is rendered
    expect(find.byType(AppHeader), findsOneWidget);

    // Check if a known chat name is rendered
    expect(find.text("Loretta Russell"), findsOneWidget);
    expect(find.text("Nina Greer"), findsOneWidget);

    // Tap on a chat item
    await tester.tap(find.text("Loretta Russell"));
    await tester.pumpAndSettle();

    // Verify navigation to IndividualChatScreen
    expect(find.byType(IndividualChatScreen), findsOneWidget);
    expect(find.text("Loretta Russell"), findsOneWidget);
  });
}
