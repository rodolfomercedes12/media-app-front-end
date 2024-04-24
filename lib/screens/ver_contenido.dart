import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:media_content_app/models/contenido.dart';

import '../models/tematica.dart';



class VerContenido extends StatefulWidget {
  const VerContenido({super.key});

  @override
  State<VerContenido> createState() => _VerContenidoState();
}

class _VerContenidoState extends State<VerContenido> {
   final scrollController = ScrollController();
   List<Contenido> contenidos = [];
     bool _isLoading = false;
      List<Tematica> _tematicas = [];
      String? filtroSeleccionado;



      Future<void> _fetchTematicas() async {
    
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/api/media/getTematicas'));

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final List<dynamic> tematicasJson = json.decode(response.body)['tematicas'];
      setState(() {
        _tematicas = tematicasJson.map((tematica) => Tematica.fromJson(tematica)).toList();
      });
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }



   Future<void> _fetchContenidos() async {
    
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/api/media/getContenidos'));

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final List<dynamic> contenidosJson = json.decode(response.body)['contenidos'];
      setState(() {
        contenidos = contenidosJson.map((contenido) => Contenido.fromJson(contenido)).toList();
      });
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }

  @override
  void initState() {
    _fetchContenidos();
    _fetchTematicas();
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Center(
                child: Text("Contenido", style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold )),
                
              ),
              SizedBox(height: 30,),
            
              Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 600,
          child: ListView.builder(
         
          itemCount: contenidos.length,
          itemBuilder: (BuildContext context, int index) {
            final contenido = contenidos[index];
            print(contenidos.length);

            return contenidos.length == 0 ? Center(
              child: Text("No hay contenido disponibles."),
            ) :  Padding(
              padding: const EdgeInsets.all(8.0),
              child: FadeInUp(
                child: Column(
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
                      image: NetworkImage(contenido.urlImagen!),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 5,),
                    ListTile(
                      title: Text(contenido.titulo!, style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                      )),
                      subtitle: Text(contenido.tematica!.nombre!, style: TextStyle(
                        color: Colors.grey
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text("Creditos:", style: TextStyle( fontSize: 16, color: Colors.black.withOpacity(0.8) ),),
                          SizedBox(width: 15,),
                          Text(contenido.creador!.username!)
                        ],
                      ),
                    )
              
                  ],
                ),
              )
            );
          },
          ),
        ),
       
        
          ),
          SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}