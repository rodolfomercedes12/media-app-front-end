import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_content_app/helpers/alerta.dart';
import 'package:media_content_app/screens/agregar_categoria.dart';
import 'package:media_content_app/screens/agregar_contenido.dart';
import 'package:media_content_app/screens/agregar_tematica.dart';
import 'package:media_content_app/screens/ver-categorias.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/media/media_bloc.dart';
import 'ver_contenido.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {


  @override
  void initState() {
    final mediaBloc = BlocProvider.of<MediaBloc>(context, listen: false);
    mediaBloc.fetchCategorias();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        
      ),
     
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
        child:  Column(
         
          children: [
            const SizedBox(height: 40,),
            Image.asset("assets/images/media_app_logo.jpg", width: 100, height: 100,),
            const Center(child: Text("MediaContent App", style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),)),
             const Center(child: Text("Disruptive Studios", style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: Colors.grey
            ),)),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¡Bienvenido(a)!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),),
                const SizedBox(width: 15,),
                 Text(state.usuario.username!, style: TextStyle(fontSize: 16, color: Colors.grey),)
              ],
            ),

            const SizedBox(height: 30,),
             FilledButton(
                  style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const VerContenido())  );
                  },
                   child: const Text("Ver Contenido")
                   ),
                   const  SizedBox(height: 15,),



                 FilledButton(
                  style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: (){
                    if( state.usuario.roll == "admin" || state.usuario.roll == "creador") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const VerCategorias())  );
                    } else{
                      mostrarWarning(context, "No cuentas con permisos", Icons.warning );
                    }
                  },
                   child: const Text("Ver Categorías")
                   ),
                    const  SizedBox(height: 15,),



                 FilledButton(
                  style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: (){
                    if( state.usuario.roll == "admin" || state.usuario.roll == "creador") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AgregarCategoria())  );
                    } else{
                      mostrarWarning(context, "No cuentas con permisos", Icons.warning );
                    }
                  },
                   child: const Text("Agregar Categoría")
                   ),
                    const  SizedBox(height: 15,),



            FilledButton(
                  style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: (){
                    if( state.usuario.roll == "admin" || state.usuario.roll == "creador") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>  TematicaForm())  );
                    } else{
                      mostrarWarning(context, "No cuentas con permisos", Icons.warning );
                    }
                  },
                   child: const Text("Agregar Temática")
                   ),
                  const  SizedBox(height: 15,),




                  FilledButton(
                  style:const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  onPressed: (){
                    if( state.usuario.roll == "admin" || state.usuario.roll == "creador") {
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>  AgregarContenido())  );
                    } else{
                      mostrarWarning(context, "No cuentas con permisos", Icons.warning );
                    }
                  },
                   child: const Text("Agregar Contenido")
                   ),
                    const  SizedBox(height: 15,),

                    
            
          ],
        ),
      );
        },
      )
    );
  }
}