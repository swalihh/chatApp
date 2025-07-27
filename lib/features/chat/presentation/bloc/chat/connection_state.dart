part of 'connection_bloc.dart';

class ConnectionsState extends Equatable {
  final WsConnectionStatus status;
  const ConnectionsState({this.status = WsConnectionStatus.connecting});

  ConnectionsState copyWith({WsConnectionStatus? status}) {
    return ConnectionsState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}

