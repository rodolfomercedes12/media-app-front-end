import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_content_app/helpers/alerta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import '../../models/categoria.dart';
import '../../models/tematica.dart';
import '../socket/socket_bloc.dart';
import 'package:http/http.dart' as http;

part 'media_event.dart';
part 'media_state.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {


  final SocketBloc socketBloc;
  
  final picker = ImagePicker();
  final cloudinary = CloudinaryPublic('dgfwstivj', 'p5lv7pqz');


  MediaBloc({ required this.socketBloc }) : super(const MediaState( urlImagenCategoria: "", categorias: [], tematicas: [])) {
    on<MediaEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SetImage>( (event, emit) {
      emit(state.copyWith(urlImagenCategoria: event.urlImagen));
    });

    on<SetCategories>( (event, emit) {
      
      emit(state.copyWith(categorias: event.categories));
    });

    on<SetLoading>( (event, emit) {
      
      emit(state.copyWith(loading: event.isLoading));
    });




  }

   Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    add(SetImage(pickedFile!.path));
   
  }

   Future<void> fetchCategorias() async {

   
    
    final response = await http.get(Uri.parse('http://10.0.2.2:9000/api/media/getCategories'));

    add(const SetLoading(false));

    if (response.statusCode == 200) {
     
      final List<dynamic> categoriasJson = json.decode(response.body)['categorias'];
      add( SetCategories( categoriasJson.map((categoria) => Categoria.fromJson(categoria)).toList() ) );
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }




   Future<void> deleteCategory( BuildContext context, String idCategory ) async {

  
     mostrarLoading(context);
    
    final response = await http.delete(Uri.parse('http://10.0.2.2:9000/api/media/deleteCategory'), body:jsonEncode({
      "categoryId" : idCategory
    }),  headers: {'Content-Type': 'application/json'},);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      await fetchCategorias();
     
      mostrarSnackBar(context, "Categoría eliminada", Icons.check);
    } else {
      throw Exception('Error al obtener las categorías');
    }
  }

  
}
