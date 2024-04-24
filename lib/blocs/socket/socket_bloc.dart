import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../global/environment.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {

  IO.Socket? _sock;

  IO.Socket get socket => this._sock!;

  SocketBloc() : super(const SocketState(serverStatus: ServerStatus.Loading)) {
    on<ServerStatusOnline>((event, emit) {
      emit(state.copyWith(serverStatus: ServerStatus.Online));
    });

    on<ServerStatusOffline>((event, emit) {
      emit(state.copyWith(serverStatus: ServerStatus.Offline));
    });
  }



  void connect() async {
   

    _sock = IO.io(
        Environment.socketURL,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect() 
            .setExtraHeaders({'foo': 'bar'}) 
            .build());

    _sock!.connect();
    _sock!.onConnect((_) {
     
      add(ServerStatusOnline());
    });

    _sock!.onDisconnect((_) {
      add(ServerStatusOffline());
    });
  }

  void disconnect() {
    _sock!.disconnect();
    add(ServerStatusOffline());
  }
}
