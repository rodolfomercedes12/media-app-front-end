import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../helpers/alerta.dart';
import '../../models/usuario.dart';
import '../../repository/auth_repository.dart';
import '../socket/socket_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final SocketBloc socketBloc;

  AuthBloc({required this.authRepository, required this.socketBloc})
      : super(AuthState(autenticando: false, usuario: Usuario())) {
    on<OnLoginEvent>((event, emit) async {

      add(OnSetAutenticandoEvent(value: true));
      final respLogin = await authRepository.login(event.email, event.username);
      add(OnSetAutenticandoEvent(value: false));
      if (respLogin.ok!) {
        add(SetUserEvent(usuario: respLogin.usuario!));
        socketBloc.connect();
        Navigator.pushReplacementNamed(event.context, "home");
      } else {
        mostrarAlerta(
            event.context, "Login incorrecto", "Revise sus credenciales", (){});
      }
    });

    on<OnRegisterEvent>((event, emit) async {
      add(OnSetAutenticandoEvent(value: true));
      final respLogin = await authRepository.register(
          event.username, event.email, event.roll, event.context);
      add(OnSetAutenticandoEvent(value: false));
      if (respLogin == true) {
        socketBloc.connect();
        Navigator.pushReplacementNamed(event.context, "home");
      } else {
        mostrarAlerta(event.context, "Registro incorrecto", respLogin, (){});
      }
    });

    on<OnSetAutenticandoEvent>(
        (event, emit) => emit(state.copyWith(autenticando: event.value)));

    on<SetUserEvent>(
        (event, emit) => emit(state.copyWith(usuario: event.usuario)));
  }


}

