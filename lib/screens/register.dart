import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String rollType = "lector";
   TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

     final authBloc = BlocProvider.of<AuthBloc>(context);

    return   Scaffold(
      appBar: AppBar(
        
      ),
      body: SingleChildScrollView(
        child:  Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
           
            children: [
              const SizedBox(height: 40,),
              Image.asset("assets/images/media_app_logo.jpg", width: 100, height: 100,),
              const Center(child: Text("Regístrate", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),)),
              
              const SizedBox(height: 30,),
             
                TextField(
                controller: usernameController,
                  decoration: InputDecoration(
                    label: Text("Nombre de usuario"),
                    hintText: "Ingrese su usuario"
                  ),
                ),
                SizedBox(height: 15,),

                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text("Correo electrónico"),
                    hintText: "Ingrese su correo"
                  ),
                ),
                SizedBox(
                  height: 40,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          rollType = "lector";
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey
                          ),
                          color:  rollType == "lector" ? Colors.black : Colors.white
                        ),
                        child: Center(child: Text("Lector", style: TextStyle( 
                          fontWeight: FontWeight.normal,
                           color: rollType == "lector" ? Colors.white : Colors.black
                            ),)),
                      ),
                    ),
                    SizedBox(width: 30,),

                     GestureDetector(
                      onTap:(){
                         setState(() {
                          rollType = "creador";
                        });
                      },
                       child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.grey
                          ),
                          color: rollType == "creador" ? Colors.black : Colors.white
                        ),
                        child: Center(child: Text("Creador", style: TextStyle( 
                          fontWeight: FontWeight.normal,
                          color: rollType == "creador" ? Colors.white : Colors.black
                           ),)),
                                         ),
                     ),
                  ],
                ),
                SizedBox(height: 25,),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: (){
                       authBloc.add(OnRegisterEvent(
                                email: emailController.text.trim(),
                                roll: rollType,
                                username: usernameController.text.trim(),
                                context: context
                                ));
                    },
                    style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                   child: Text("Registrarse") )
                ),
                      
              
            ],
          ),
        ),
      )
    );
  }
}