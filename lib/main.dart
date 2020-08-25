import 'package:app_dia_dos_namorados/screens/carta.dart';
import 'package:app_dia_dos_namorados/screens/detalhe_presente.dart';
import 'package:app_dia_dos_namorados/screens/home.dart';
import 'package:app_dia_dos_namorados/screens/lista_presentes.dart';
import 'package:flutter/material.dart';

void main() => runApp(AppDiaNamorados());

class AppDiaNamorados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      theme: ThemeData.light(),
      initialRoute: "/",
      routes: {
        "/": (context) => Home(),
        "/carta": (context) => Carta(),
        "/lista_presentes" : (context) => ListaPresentes(),
        "/detalhe_presente" : (context) => DetalhePresente(),
      },
    );
  }
  
}