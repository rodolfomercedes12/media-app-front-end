

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_content_app/helpers/alerta.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/media/media_bloc.dart';

class VerCategorias extends StatefulWidget {
  const VerCategorias({super.key});

  @override
  State<VerCategorias> createState() => _VerCategoriasState();
}

class _VerCategoriasState extends State<VerCategorias> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listado de categorias"),
      ),
      body: BlocBuilder<MediaBloc, MediaState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.categorias.length,
            itemBuilder: (BuildContext context, int index) {

              final category = state.categorias[index];


              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 300,
                      child: GestureDetector(
                              onTap: () => print("data"),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: FadeInImage(
                      height: 180,
                      fit: BoxFit.cover,
                      placeholder: const AssetImage('assets/images/no-image.png'),
                      image: NetworkImage(category.urlImagen),
                                ),
                              ),
                      ),
                    ),
                  ListTile(
                    title: Text(category.nombre),
                    
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return TextButton(
                          onPressed: (){
                           if(state.usuario.roll == "admin") {
                             mostrarAlerta(context, "¿Eliminar esta categoría?", "Se borrará permanentemente", (){
                              final mediaBloc = BlocProvider.of<MediaBloc>(context, listen: false);
                             mediaBloc.deleteCategory(context, category.uid);
                            });
                           }else {
                            mostrarWarning(context, "No cuentas con permisos", Icons.warning);
                           }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.red),
                          ),
                          child: Text("Eliminar Categoría", style: TextStyle( color: Colors.white )) );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ) ;
            },
          );
        },
      )
    );
  }
}