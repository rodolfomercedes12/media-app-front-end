
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../global/environment.dart';
import '../response/login_response.dart';
import 'package:http/http.dart' as http;

class AuthRepository {


  
  Future<LoginResponse> login(String email, String password) async {
    final data = {"email": email, "username": password};

    final response = await http.post(Uri.parse("${Environment.apiURL}/login"),
        body: jsonEncode(data), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);


      return loginResponse;
    } else {
      return LoginResponse(ok: false);
    }
  }

  Future register(
      String username, String email, String roll, BuildContext context) async {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    final data = {"email": email, "username": username, "roll": roll};

    final http.Response response = await http.post(
        Uri.parse("${Environment.apiURL}/login/new"),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"});



    if (response.statusCode == 200) {
      final loginResponse = loginResponseFromJson(response.body);
      authBloc.add(SetUserEvent(usuario: loginResponse.usuario!));
     
   

      return true;
    } else {
      final respBody = jsonDecode(response.body);
      return respBody["msg"];
    }
  }


}