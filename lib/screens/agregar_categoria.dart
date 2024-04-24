import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/media/media_bloc.dart';
import '../blocs/socket/socket_bloc.dart';
import '../helpers/alerta.dart';

class AgregarCategoria extends StatefulWidget {
  const AgregarCategoria({super.key});

  @override
  State<AgregarCategoria> createState() => _AgregarCategoriaState();
}

class _AgregarCategoriaState extends State<AgregarCategoria> {

  final categoriaController = TextEditingController();
   SocketBloc? socketBloc;
   MediaBloc? mediaBloc;
   String urlImagen = "";
    final picker = ImagePicker();
     final cloudinary = CloudinaryPublic('dgfwstivj', 'p5lv7pqz');

   @override
  void initState() {
    socketBloc = BlocProvider.of<SocketBloc>(context, listen: false);
    mediaBloc = BlocProvider.of<MediaBloc>(context);
   
   
    super.initState();
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


  uploadCategory() async{
    print(categoriaController.text);
    String categoryName = categoriaController.text.trim();
     mostrarLoading(context);
      final response = await cloudinary
        .uploadFile(
      CloudinaryFile.fromFile(urlImagen),
    ).then((result) {
      Navigator.pop(context);
      socketBloc?.socket.emit("crear-categoria", { "urlImagen": result.secureUrl, "nombre": categoryName });
      mostrarSnackBar(context, "Categoria creada", Icons.check);
    });
  }

  @override
  Widget build(BuildContext context) {

   

    return  Scaffold(
      appBar: AppBar(),
      body:  Padding(
        padding: const EdgeInsets.symmetric( horizontal: 25 ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SizedBox(height: 70,),
              const Text("Agregar Categoria", style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),),
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
                TextField(
                  controller: categoriaController,
                  decoration: InputDecoration(
                    label: Text("Categoría"),
                    hintText: "Nombre de la categoría"
                  ),
                ),
                SizedBox(height: 30,),
                 SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: FilledButton(
                      onPressed: (){
                       uploadCategory();
                      },
                      style:const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                     child: Text("Agregar") )
                  ),
               
            ],
          ),
        ),
      ),
    );
  }
}