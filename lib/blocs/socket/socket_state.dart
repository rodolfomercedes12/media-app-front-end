part of 'socket_bloc.dart';

enum ServerStatus { Online, Offline, Loading }

class SocketState extends Equatable {
  final ServerStatus serverStatus;

  const SocketState( { required this.serverStatus } );


  SocketState copyWith ({
    ServerStatus? serverStatus
  }) => SocketState( serverStatus: serverStatus ?? this.serverStatus );

  @override
  List<Object> get props => [ serverStatus ];
}
