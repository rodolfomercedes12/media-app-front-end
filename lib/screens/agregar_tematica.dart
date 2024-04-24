import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:media_content_app/blocs/media/media_bloc.dart';
import 'package:media_content_app/helpers/alerta.dart';

import '../models/categoria.dart';

class TematicaForm extends StatefulWidget {
  @override
  _TematicaFormState createState() => _TematicaFormState();
}

class _TematicaFormState extends State<TematicaForm> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _permisos = <String>['Imagenes', 'Videos', 'Texto'];
  final _selectedPermisos = <String>[];
  bool _isLoading = false;
  List<Categoria> _categorias = [];
  Categoria? _selectedCategoria;

  @override
  void initState() {
     _fetchCategorias();
    super.initState();
   
  }

  Future<void> _fetchCategorias() async {
    
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/api/media/getCategories'));

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final mediaBloc = BlocProvider.of<MediaBloc>(context, listen: false);
      final List<dynamic> categoriasJson = json.decode(response.body)['categorias'];
      setState(() {
        _categorias = categoriasJson.map((categoria) => Categoria.fromJson(categoria)).toList();
      });
      mediaBloc.add(SetCategories(_categorias));
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }



   Future<void> _crearTematica() async {
    mostrarLoading(context);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:9000/api/media/crearTematica'),
      body: json.encode({
        'nombre': _nombreController.text,
        'categoria': _selectedCategoria?.uid,
         'permisos': _selectedPermisos,
       
      }),
      headers: {'Content-Type': 'application/json'},
    );
    Navigator.pop(context);


    if (response.statusCode == 200) {
     
      print('Temática creada con éxito');
      mostrarSnackBar(context, "Temática creada", Icons.check);
    } else {
     
      mostrarSnackBar(context, "Ya existe esta temática", Icons.thumb_down);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Tematica'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Agregar Temática',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce un nombre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text('Categoría'),
                DropdownButtonFormField<Categoria>(
                  value: _selectedCategoria,
                  items: _categorias.map((Categoria categoria) {
                    return DropdownMenuItem<Categoria>(
                      value: categoria,
                      child: Text(categoria.nombre),
                    );
                  }).toList(),
                  onChanged: (Categoria? value) {
                    setState(() {
                      _selectedCategoria = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                  ),
                  validator: (Categoria? value) {
                    if (value == null) {
                      return 'Por favor, selecciona una categoría';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                Text('Permisos'),
                Container(
                 
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
                ),
                SizedBox(height: 20.0),
                   SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: FilledButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                    
                      _crearTematica();
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