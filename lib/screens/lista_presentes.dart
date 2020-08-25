import 'package:app_dia_dos_namorados/models/permissao_model.dart';
import 'package:app_dia_dos_namorados/models/presente_model.dart';
import 'package:app_dia_dos_namorados/services/permissao_service.dart';
import 'package:app_dia_dos_namorados/services/presente_service.dart';
import 'package:flutter/material.dart';

class ListaPresentes extends StatefulWidget {
  List<PresenteModel> presentes = null;
  PermissaoModel permissaoModel = null;

  @override
  _ListaPresentesState createState() => _ListaPresentesState();
}

class _ListaPresentesState extends State<ListaPresentes> {
  var solicitarSenha = false;
  var permitido = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var _senhaDigitada = "";
  PresenteModel presenteSelecionado = null;

  void getPermissao() async {
    try {
      if (widget.permissaoModel != null) return;

      widget.permissaoModel = await PermissaoService().first();
      permitido = widget.permissaoModel.permitido;
    } catch (erro) {}
  }

  @override
  Widget build(BuildContext context) {
    getPermissao();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromRGBO(249, 155, 176, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 88, 123, 1),
        title: Text("lista de presentes",
            style: TextStyle(fontFamily: "Quicksand", color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _buildList(),
          ),
          if (solicitarSenha && !permitido)
            Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () => setState(() => {solicitarSenha = false}),
                  child: Container(
                    color: Color.fromRGBO(249, 155, 176, 0.4),
                    child: null,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Color.fromRGBO(245, 88, 123, 1),
                        height: 130,
                        width: MediaQuery.of(context).size.width * 0.95,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text("senha",
                                    style: TextStyle(
                                        fontFamily: "Quicksand",
                                        color: Colors.white,
                                        fontSize: 30)),
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
                                      onChanged: (value) =>
                                          _senhaDigitada = value,
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
                                        hintStyle:
                                            TextStyle(fontFamily: "Quicksand"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 16.0, bottom: 16),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (widget.permissaoModel == null) return;

                                      if (_senhaDigitada !=
                                          widget.permissaoModel.senha)
                                        scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            backgroundColor:
                                                Color.fromRGBO(245, 88, 123, 1),
                                            content: Text(
                                              'Senha incorreta!',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  color: Colors.white,
                                                  fontSize: 24),
                                            ),
                                          ),
                                        );
                                      else {
                                        _navigateToDetalhe(presenteSelecionado);
                                        _senhaDigitada = "";

                                        widget.permissaoModel.permitido = true;

                                        PermissaoService()
                                            .update(widget.permissaoModel);

                                        setState(
                                            () => {solicitarSenha = false});
                                      }
                                    },
                                    child: Container(
                                      height: 60,
                                      width: 64,
                                      color: Color.fromRGBO(247, 121, 150, 1),
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
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildList() {
    if (widget.presentes == null) {
      return FutureBuilder(
        future: PresenteService().findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError)
              return Center(
                child: Text(
                  "Erro ao carregar a lista de presentes",
                  // textAlign: TextAlign.center,
                ),
              );
            else {
              widget.presentes = snapshot.data;

              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) =>
                    _buildCard(context, snapshot.data[index]),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(245, 88, 123, 1)),
              ),
            );
          }
        },
      );
    } else {
      return ListView.builder(
        itemCount: widget.presentes.length,
        itemBuilder: (context, index) =>
            _buildCard(context, widget.presentes[index]),
      );
    }
  }

  void _navigateToDetalhe(PresenteModel presente) async {
    await Navigator.pushNamed(context, "/detalhe_presente",
        arguments: presente);
    setState(() {});
  }

  Padding _buildCard(BuildContext context, PresenteModel presenteModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (widget.permissaoModel != null &&
                widget.permissaoModel.permitido) {
              _navigateToDetalhe(presenteModel);
            } else {
              presenteSelecionado = presenteModel;
              setState(() {
                solicitarSenha = true;
              });
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color.fromRGBO(247, 121, 150, 1),
              width: MediaQuery.of(context).size.width * 0.87,
              height: MediaQuery.of(context).size.width * 0.87,
              child: !presenteModel.aberto
                        ? Image.asset("assets/images/presente.png",  scale: 2)
                        : Image.network(presenteModel.urlFoto, scale: 2.3,),
            ),
          ),
        ),
      ),
    );
  }
}
