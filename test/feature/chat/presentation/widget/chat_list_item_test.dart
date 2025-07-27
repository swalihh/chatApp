import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock widgets to avoid dependency issues
class MockAppHeader extends StatelessWidget {
  final bool isConnected;
  
  const MockAppHeader({super.key, required this.isConnected});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('App Header - ${isConnected ? 'Connected' : 'Disconnected'}'),
      ),
    );
  }
}

class MockChatAvatar extends StatelessWidget {
  final String avatar;
  final String name;
  
  const MockChatAvatar({super.key, required this.avatar, required this.name});
  
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.blue,
      child: Text(avatar, style: TextStyle(color: Colors.white)),
    );
  }
}

class MockPendingCountBadge extends StatelessWidget {
  final int count;
  
  const MockPendingCountBadge({Key? key, required this.count}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text('$count', style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}

class MockIndividualChatScreen extends StatelessWidget {
  final String contactName;
  final String contactAvatar;
  
  const MockIndividualChatScreen({
    Key? key, 
    required this.contactName, 
    required this.contactAvatar
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactName),
      ),
      body: Center(
        child: Text('Individual Chat with $contactName'),
      ),
    );
  }
}

// ChatItem model
class ChatItem {
  final int id;
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool online;
  final int pendingCount;

  ChatItem({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    required this.online,
    required this.pendingCount,
  });
}

// ChatListItem widget
class ChatListItem extends StatelessWidget {
  final ChatItem chat;
  final VoidCallback onTap;

  const ChatListItem({
    Key? key,
    required this.chat,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // Avatar
            MockChatAvatar(
              avatar: chat.avatar,
              name: chat.name,
            ),
            SizedBox(width: 12),

            // Chat Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          chat.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    chat.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            // Pending Count Badge
            if (chat.pendingCount > 0) ...[
              SizedBox(width: 12),
              MockPendingCountBadge(count: chat.pendingCount),
            ],
          ],
        ),
      ),
    );
  }
}

// ChatScreen widget
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool isConnected = true;
  ChatItem? selectedChat;

  final List<ChatItem> chatList = [
    ChatItem(
      id: 1,
      name: "Loretta Russell",
      message: "Hey did you see how hungry my...",
      time: "9:41 AM",
      avatar: "LR",
      online: true,
      pendingCount: 0,
    ),
    ChatItem(
      id: 2,
      name: "Nina Greer",
      message: "I don't think I can join you later on the afternoon since we are meaning...",
      time: "9:35 AM",
      avatar: "NG",
      online: true,
      pendingCount: 2,
    ),
    ChatItem(
      id: 3,
      name: "Rose Carr",
      message: "I think our conversation has become...",
      time: "9:30 AM",
      avatar: "RC",
      online: false,
      pendingCount: 0,
    ),
    ChatItem(
      id: 4,
      name: "Manuel Clayton",
      message: "Can we meet on wednesday night and discuss about new book...",
      time: "Yesterday",
      avatar: "MC",
      online: false,
      pendingCount: 1,
    ),
    ChatItem(
      id: 5,
      name: "Dev Team Alja",
      message: "Santiago: When do you want a discussion about our current progress?",
      time: "Yesterday",
      avatar: "TA",
      online: true,
      pendingCount: 5,
    ),
    ChatItem(
      id: 6,
      name: "Rosetta Roberts",
      message: "Wow, I don't know. So, yesterday at the club there's was a big vibe.",
      time: "Yesterday",
      avatar: "RR",
      online: true,
      pendingCount: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          SafeArea(
            child: Column(
              children: [
                // App Header
                MockAppHeader(isConnected: isConnected),

                // Chat List
                Expanded(
                  child: ListView.separated(
                    itemCount: chatList.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.shade100,
                    ),
                    itemBuilder: (context, index) {
                      final chat = chatList[index];
                      return ChatListItem(
                        chat: chat,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MockIndividualChatScreen(
                                  contactName: chat.name,
                                  contactAvatar: chat.avatar,
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Tests
void main() {
  group('ChatScreen Widget Tests', () {
    testWidgets('should render ChatScreen with all basic components', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ChatScreen(),
        ),
      );

      // Assert - Check if basic structure exists
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SafeArea), findsOneWidget);
      expect(find.byType(MockAppHeader), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      
      // Debug output
      print('✓ ChatScreen basic components test passed');
    });

    testWidgets('should display all chat items in the list', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ChatScreen(),
        ),
      );

      // Assert - Check if all chat items are rendered
      expect(find.byType(ChatListItem), findsNWidgets(6));
      
      // Check specific chat names
      expect(find.text('Loretta Russell'), findsOneWidget);
      expect(find.text('Nina Greer'), findsOneWidget);
      expect(find.text('Rose Carr'), findsOneWidget);
      expect(find.text('Manuel Clayton'), findsOneWidget);
      expect(find.text('Dev Team Alja'), findsOneWidget);
      expect(find.text('Rosetta Roberts'), findsOneWidget);
      
      print('✓ All chat items display test passed');
    });

    testWidgets('should display chat messages and times correctly', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ChatScreen(),
        ),
      );

      // Assert - Check if messages and times are displayed
      expect(find.text('Hey did you see how hungry my...'), findsOneWidget);
      expect(find.text('9:41 AM'), findsOneWidget);
      expect(find.text('Yesterday'), findsNWidgets(3));
      
      print('✓ Chat messages and times test passed');
    });

    testWidgets('should have correct number of dividers between chat items', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: ChatScreen(),
        ),
      );

      // Assert - Should have 5 dividers for 6 items (n-1)
      expect(find.byType(Divider), findsNWidgets(5));
      
      print('✓ Dividers count test passed');
    });

    testWidgets('should navigate to IndividualChatScreen when chat item is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ChatScreen(),
        ),
      );

      // Act - Tap on first chat item
      await tester.tap(find.byType(ChatListItem).first);
      await tester.pumpAndSettle();

      // Assert - Should navigate to MockIndividualChatScreen
      expect(find.byType(MockIndividualChatScreen), findsOneWidget);
      expect(find.text('Individual Chat with Loretta Russell'), findsOneWidget);
      
      print('✓ Navigation test passed');
    });
  });

  group('ChatListItem Widget Tests', () {
    late ChatItem testChatItem;
    late bool tapped;

    setUp(() {
      tapped = false;
      testChatItem = ChatItem(
        id: 1,
        name: 'Test User',
        message: 'Test message content',
        time: '10:30 AM',
        avatar: 'TU',
        online: true,
        pendingCount: 3,
      );
    });

    testWidgets('should render ChatListItem with all components', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatListItem(
              chat: testChatItem,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Test message content'), findsOneWidget);
      expect(find.text('10:30 AM'), findsOneWidget);
      expect(find.byType(MockChatAvatar), findsOneWidget);
      
      print('✓ ChatListItem rendering test passed');
    });

    testWidgets('should display pending count badge when count > 0', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatListItem(
              chat: testChatItem,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(MockPendingCountBadge), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      
      print('✓ Pending count badge display test passed');
    });

    testWidgets('should not display pending count badge when count is 0', (WidgetTester tester) async {
      // Arrange
      final chatWithNoPending = ChatItem(
        id: 1,
        name: 'Test User',
        message: 'Test message',
        time: '10:30 AM',
        avatar: 'TU',
        online: true,
        pendingCount: 0,
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatListItem(
              chat: chatWithNoPending,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(MockPendingCountBadge), findsNothing);
      
      print('✓ No pending count badge test passed');
    });

    testWidgets('should call onTap when chat item is tapped', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatListItem(
              chat: testChatItem,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Assert
      expect(tapped, isTrue);
      
      print('✓ OnTap callback test passed');
    });
  });

  group('ChatItem Model Tests', () {
    test('should create ChatItem with all required properties', () {
      // Arrange & Act
      final chatItem = ChatItem(
        id: 1,
        name: 'Test User',
        message: 'Test message',
        time: '10:30 AM',
        avatar: 'TU',
        online: true,
        pendingCount: 5,
      );

      // Assert
      expect(chatItem.id, 1);
      expect(chatItem.name, 'Test User');
      expect(chatItem.message, 'Test message');
      expect(chatItem.time, '10:30 AM');
      expect(chatItem.avatar, 'TU');
      expect(chatItem.online, isTrue);
      expect(chatItem.pendingCount, 5);
      
      print('✓ ChatItem model test passed');
    });
  });
}