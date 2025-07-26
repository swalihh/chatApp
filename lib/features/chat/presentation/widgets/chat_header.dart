import 'package:flutter/material.dart';
import 'connection_status.dart';

class AppHeader extends StatelessWidget {
  final bool isConnected;

  const AppHeader({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chatting",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),
          ConnectionStatus(isConnected: isConnected),
        ],
      ),
    );
  }
}
