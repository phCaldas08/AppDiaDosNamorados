import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var diasRestantes =
        DateTime.parse("2020-05-29").difference(DateTime.now()).inDays;
    var podeContinuar =
        DateTime.parse("2020-05-29").difference(DateTime.now()).isNegative;
    var txtCoracao = podeContinuar ? "continuar" : "$diasRestantes dias";

    return Scaffold(
      backgroundColor: Color.fromRGBO(249, 155, 176, 1),
      body: GestureDetector(
        onTap: () =>
            {if (podeContinuar) Navigator.pushNamed(context, "/carta")},
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.23),
                child: Text(
                  podeContinuar ? "" : "faltam",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Quicksand",
                      fontSize: 45),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(
                child: Image.asset("assets/images/coracao.png"),
              ),
            ),
            Center(
              child: Text(
                txtCoracao,
                style: TextStyle(
                    color: Colors.white, fontFamily: "Quicksand", fontSize: 45),
              ),
            )
          ],
        ),
      ),
    );
  }
}
