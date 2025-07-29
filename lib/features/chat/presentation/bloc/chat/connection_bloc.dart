import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/network/websocket_service.dart';

part 'connection_event.dart';
part 'connection_state.dart';

class ConnectionBloc extends Bloc<ConnectionEvent, ConnectionsState> {
  final WebSocketService service;
  StreamSubscription<WsConnectionStatus>? _sub;

  ConnectionBloc(this.service) : super(const ConnectionsState()) {
    on<ConnectionStarted>(_onStarted);
    on<_StatusChanged>(_onStatusChanged);

    add(const ConnectionStarted());
  }

  void _onStarted(ConnectionStarted event, Emitter<ConnectionsState> emit) {
    _sub = service.connectionStatus.listen((status) {
      add(_StatusChanged(status));
    });
    service.connect();
  }

  void _onStatusChanged(_StatusChanged event, Emitter<ConnectionsState> emit) {
    emit(state.copyWith(status: event.status));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    service.disconnect();
    return super.close();
  }
}
