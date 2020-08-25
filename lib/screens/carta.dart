import 'package:app_dia_dos_namorados/models/carta_model.dart';
import 'package:app_dia_dos_namorados/services/carta_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Carta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateCarta();
}

class _StateCarta extends State<Carta> {
  CartaModel cartaModel = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 155, 176, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 44),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Color.fromRGBO(247, 121, 150, 1),
            child: FutureBuilder(
              future: CartaService().first(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError)
                    return Center(
                      child: Text(
                        "Erro ao carregar carta",
                        // textAlign: TextAlign.center,
                      ),
                    );
                  else {
                    cartaModel = snapshot.data;

                    return Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              cartaModel.titulo,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16, top: 104),
                          child: SingleChildScrollView(
                            child: Text(
                              cartaModel.texto,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(249, 155, 176, 1)),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, "/lista_presentes"),
            child: Container(
              color: Color.fromRGBO(245, 88, 123, 1),
              alignment: Alignment.center,
              height: 60,
              child: Text("avançar",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontSize: 30)),
            ),
          ),
        ),
      ),
    );
  }
}
