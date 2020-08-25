import 'package:app_dia_dos_namorados/models/presente_model.dart';
import 'package:app_dia_dos_namorados/services/presente_service.dart';
import 'package:flutter/material.dart';

class DetalhePresente extends StatefulWidget {
  @override
  _DetalhePresenteState createState() => _DetalhePresenteState();
}

class _DetalhePresenteState extends State<DetalhePresente> {
  var senhaDigitada = "";
  PresenteModel presenteModel = null;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    presenteModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(249, 155, 176, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 88, 123, 1),
        title: Text(
            presenteModel.aberto
                ? presenteModel.descricao
                : "presente nº ${presenteModel.id}",
            style: TextStyle(fontFamily: "Quicksand", color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Color.fromRGBO(247, 121, 150, 1),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: !presenteModel.aberto
                        ? Image.asset("assets/images/presente.png", height: 240)
                        : Image.network(presenteModel.urlFoto, height: 240),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 270, left: 16, right: 16, bottom: 100),
                  child: SingleChildScrollView(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        presenteModel.texto,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Quicksand",
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16, bottom: 16, right: 80),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)),
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          onChanged: (value) => senhaDigitada = value,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          style: TextStyle(fontFamily: "Quicksand"),
                          decoration: new InputDecoration(
                            focusColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Colors.white,
                              ),
                            ),
                            hintText: "digite a senha",
                            hintStyle: TextStyle(fontFamily: "Quicksand"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: _abrirPresente,
                        child: Container(
                          height: 60,
                          width: 64,
                          color: Color.fromRGBO(245, 88, 123, 1),
                          child: Center(
                            child: Text(
                              "ok",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  color: Colors.white,
                                  fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _abrirPresente() {
    if (senhaDigitada == presenteModel.senha) {
      presenteModel.aberto = true;
      PresenteService().update(presenteModel);
      setState(() {});
    } else {
      scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Color.fromRGBO(245, 88, 123, 1),
          content: Text(
            'Senha do presente incorreta!',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Quicksand", color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }
  }
}
