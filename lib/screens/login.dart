import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_content_app/screens/register.dart';


import '../blocs/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

 

  @override
  Widget build(BuildContext context) {

   final authBloc = BlocProvider.of<AuthBloc>(context);

    return   Scaffold(
      appBar: AppBar(
        
      ),
      //drawer: Drawer(),
      body: SingleChildScrollView(
        child:  Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
           
            children: [
              const SizedBox(height: 40,),
              Image.asset("assets/images/media_app_logo.jpg", width: 100, height: 100,),
              const Center(child: Text("Iniciar Sesión", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),)),
              
              const SizedBox(height: 30,),
             
                TextField(
                controller: usernameController,
                  decoration: const InputDecoration(
                    label: Text("Nombre de usuario"),
                    hintText: "Ingrese su usuario"
                  ),
                ),
                SizedBox(height: 15,),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    label: Text("Correo electrónico"),
                    hintText: "Ingrese su correo"
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: (){
                      authBloc.add(OnLoginEvent(
                                      email: emailController.text.trim(),
                                      username:
                                          usernameController.text.trim(),
                                          context: context
                                          ));
                    },
                    style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                   child: Text("Ingresar") )
                ),

                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen() )  );
                  },
                  child: Text("No tienes una cuenta? Regístrate", style: TextStyle(
                    color: Colors.grey.shade800
                  )),
                )
                      
              
            ],
          ),
        ),
      )
    );
  }
}