import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


mostrarAlerta(BuildContext context, String titulo, String subtitulo,   Function press ) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                MaterialButton(
                  onPressed: () {
                  
                    Navigator.pop(context);
                    press();
                  },
                  elevation: 5,
                  child: Text("Ok"),
                  textColor: Colors.blue,
                ),
                 MaterialButton(
                  onPressed: () {
                  
                    Navigator.pop(context);
                   
                  },
                  elevation: 5,
                  child: Text("Cancelar"),
                  textColor: Colors.red,
                ),
              ],
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                CupertinoDialogAction(
                  child: Text("Ok"),
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}


mostrarWarning(BuildContext context, String mensaje, IconData icon) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(mensaje,
            ),
        Icon(icon, color: Colors.white)
      ],
    ),
    backgroundColor: Colors.black,
  ));
}

mostrarLoading(BuildContext context) {
  if (Platform.isAndroid) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(child: Text("Cargando...")),
              content: Container(
                  width: 100,
                  height: 60,
                  child: Center(child: CircularProgressIndicator())),
            ));
  } else {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Center(child: Text("Cargando...")),
              content: Container(
                  width: 100,
                  height: 60,
                  child: Center(child: CircularProgressIndicator())),
            ));
  }
}

mostrarSnackBar(BuildContext context, String mensaje, IconData icon) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(mensaje,
            ),
        Icon(icon, color: Colors.white)
      ],
    ),
    backgroundColor: Colors.black,
  )).closed.then((value) {
    Navigator.pop(context);
  });
}
