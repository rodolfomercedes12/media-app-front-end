import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_content_app/blocs/media/media_bloc.dart';
import 'package:media_content_app/repository/auth_repository.dart';

import 'package:media_content_app/screens/home_screen.dart';
import 'package:media_content_app/screens/login.dart';
import 'package:media_content_app/screens/register.dart';

import 'blocs/auth/auth_bloc.dart';
import 'blocs/socket/socket_bloc.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   final AuthRepository _authRepository = AuthRepository();
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SocketBloc()),
        BlocProvider(create: (_) => AuthBloc( authRepository: _authRepository, socketBloc: BlocProvider.of<SocketBloc>(_) )),
        BlocProvider(create: (_) => MediaBloc( socketBloc: BlocProvider.of<SocketBloc>(_), )),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
        initialRoute: "login",
        routes: {
          "login": (_) => const LoginScreen(),
          "register": (_) => const RegisterScreen(),
          "home": (_) => const AdminHomeScreen(),
        },
      ),
    );
  }
}


