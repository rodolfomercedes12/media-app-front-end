part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool autenticando;
  final Usuario usuario;
  

  const AuthState({required this.autenticando, required this.usuario });
    
    AuthState copyWith({
    bool? autenticando,
     Usuario? usuario,
     }) =>
      AuthState(
          autenticando: autenticando ?? this.autenticando,
          usuario: usuario ?? this.usuario,
          );

  @override
  List<Object> get props => [autenticando, usuario];
}
