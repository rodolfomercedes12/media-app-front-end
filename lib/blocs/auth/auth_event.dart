part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class OnSetAutenticandoEvent extends AuthEvent {
  final bool value;

  OnSetAutenticandoEvent({required this.value});
}

class OnLoginEvent extends AuthEvent {
  final String email;
  final String username;
  final BuildContext context;

  OnLoginEvent({required this.email, required this.username, required this.context});
}

class OnRegisterEvent extends AuthEvent {
  final String email;
  final String roll;
  final String username;
  final BuildContext context;

  OnRegisterEvent(
      {required this.email, required this.roll, required this.username, required this.context});
}

class SetUserEvent extends AuthEvent {
  final Usuario usuario;

  SetUserEvent({required this.usuario});
}
