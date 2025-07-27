import 'package:chat_app/features/chat/presentation/pages/chat_screen.dart';
import 'package:chat_app/features/chat/presentation/pages/individual_chat_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
      path: '/chat/:contactId',
      builder: (context, state) {
        final contactId = int.parse(state.pathParameters['contactId']!);
        final extra = state.extra as Map<String, dynamic>?;
        
        return IndividualChatScreen(
          contactId: contactId,
          contactName: extra?['contactName'] ?? '',
          contactAvatar: extra?['contactAvatar'] ?? '',
        );
      },
    ),
  ],
);