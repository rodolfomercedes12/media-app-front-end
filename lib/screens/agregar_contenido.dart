

import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:media_content_app/blocs/auth/auth_bloc.dart';
import 'package:media_content_app/helpers/alerta.dart';
import 'package:media_content_app/models/tematica.dart';


class AgregarContenido extends StatefulWidget {
  @override
  _AgregarContenidoState createState() => _AgregarContenidoState();
}

class _AgregarContenidoState extends State<AgregarContenido> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();

   String urlImagen = "";
    final picker = ImagePicker();
     final cloudinary = CloudinaryPublic('dgfwstivj', 'p5lv7pqz');
 // final _selectedPermisos = <String>[];
  bool _isLoading = false;
  List<Tematica> _tematicas = [];
  Tematica? _selectedTematica;

  @override
  void initState() {
     _fetchTematicas();
    super.initState();
   
  }

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

   Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //add(SetImage(pickedFile!.path));
    if (pickedFile != null) {
      //add(SetImage(pickedFile.path));
     
      print("imagen obtenida!!!");
      setState(() {
        urlImagen = pickedFile.path;
      });
      print(urlImagen);
      return true;
    } else {
      print("error imagepicker!!!");
      return false;
    }
  }

  crearContenidoYSubida() async{
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    String titulo = _tituloController.text.trim();
     mostrarLoading(context);
      final response = await cloudinary
        .uploadFile(
      CloudinaryFile.fromFile(urlImagen),
    ).then((result) async {
      final resp = await http.post(
      Uri.parse('http://10.0.2.2:9000/api/media/crearContenido'),
      body: json.encode({
        'titulo': titulo,
        'tematica': _selectedTematica?.uid,
        "creador": authBloc.state.usuario.uid,
        "urlImagen" : result.secureUrl

       
      }),
      headers: {'Content-Type': 'application/json'},
    );
      Navigator.pop(context);
      if (resp.statusCode == 200) {
     
      mostrarSnackBar(context, "Contenido creado", Icons.check);
    } else {
     
      mostrarSnackBar(context, "Ya existe este contenido", Icons.thumb_down);
    }
     
    
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Contenido'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: <Widget>[
                Center(
                  child: Text(
                    'Agregar Contenido',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                 urlImagen == ""
                 ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        
                                        getImage();
                                      },
                                      child: Text("Adjuntar imagen",
                                          style: TextStyle()),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        getImage();
                                      },
                                      icon: Icon(
                                        Icons.photo_camera,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            :  
                           urlImagen!= "" ? Center(
                             child: GestureDetector(
                              onTap: (){
                                getImage();
                              },
                               child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20.0),
                                        child: Container(
                                          width: 250,
                                          height: 300,
                                          child: FadeInImage(
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  AssetImage("assets/images/no-image.png"),
                                              image:
                                                  FileImage(File(urlImagen))),
                                        ),
                                      ),
                             ),
                           ) : SizedBox(),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(
                    labelText: 'Titulo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce un titulo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text('Tematica'),
                DropdownButtonFormField<Tematica>(
                  value: _selectedTematica,
                  items: _tematicas.map((Tematica tematica) {
                    return DropdownMenuItem<Tematica>(
                      value: tematica,
                      child: Text(tematica.nombre ?? ""),
                    );
                  }).toList(),
                  onChanged: (Tematica? value) {
                    setState(() {
                      _selectedTematica = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Temática',
                  ),
                  validator: (Tematica? value) {
                    if (value == null) {
                      return 'Por favor, selecciona una categoría';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                //Text('Permisos'),
                /*Container(
                 
                  width: double.infinity,
                  height: 200,
                  child: ListView.builder(
                    itemCount: _permisos.length,
                    itemBuilder: (context, index) {
                      final permiso = _permisos[index];
                      return CheckboxListTile(
                        activeColor: Colors.black,
                        title: Text(permiso),
                        value: _selectedPermisos.contains(permiso),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              _selectedPermisos.add(permiso);
                            } else {
                              _selectedPermisos.remove(permiso);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),*/
                SizedBox(height: 20.0),
                   SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                      print('Nombre: ${_tituloController.text}');
                      print('Categoría seleccionada: ${_selectedTematica?.nombre}');
                      
          
                      crearContenidoYSubida();
                    }
                        },
                        style:const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                       child: Text( _isLoading ? "Cargando..." : "Agregar") )
                    ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}