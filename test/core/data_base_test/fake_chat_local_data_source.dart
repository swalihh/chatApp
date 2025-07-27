

import 'package:chat_app/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:chat_app/features/chat/data/models/chat_message.dart';
import 'package:chat_app/features/chat/data/models/users_listing_model.dart';

class FakeChatLocalDataSource implements ChatLocalDataSource {
  final List<ChatMessage> storedMessages = [];
  @override
  Future<void> cacheMessage(ChatMessage message) async {
    storedMessages.add(message);
  }

  @override
  Future<List<ChatMessage>> getCachedMessages() async => storedMessages;

  @override
  Future<List<ChatMessage>> getMessagesForChat(String userA, String userB) async {
    return storedMessages
        .where((m) => (m.senderId == userA && m.receiverId == userB) ||
            (m.senderId == userB && m.receiverId == userA))
        .toList();
  }

  @override
  Future<void> cacheUserProfile(User profile) async {}

  @override
  Future<User> getCachedUserProfile(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAllCachedUserProfile() async => [];
}
