part of 'socket_bloc.dart';

abstract class SocketEvent extends Equatable {
  const SocketEvent();

  @override
  List<Object> get props => [];
}

class ServerStatusOnline extends SocketEvent {}

class ServerStatusOffline extends SocketEvent {}
