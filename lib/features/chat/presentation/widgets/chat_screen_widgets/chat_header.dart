import 'package:chat_app/core/network/websocket_service.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat/connection_bloc.dart';
import 'package:chat_app/features/chat/presentation/widgets/chat_screen_widgets/connection_status.dart';
import 'package:chat_app/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHeader extends StatefulWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeaderState();
}

class _AppHeaderState extends State<AppHeader> {
  late ConnectionBloc _connectionBloc;

  @override
  void initState() {
    super.initState();
    _connectionBloc = ConnectionBloc(locator<WebSocketService>());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 35, bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF4A76A8),
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Chatting",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<ConnectionBloc, ConnectionsState>(
              bloc: _connectionBloc,
              builder: (_, state) => ConnectionStatus(status: state.status),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _connectionBloc.close();
    super.dispose();
  }
}
