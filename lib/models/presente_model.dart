// To parse this JSON data, do
//
//     final presenteModel = presenteModelFromJson(jsonString);

import 'dart:convert';

class PresenteModel {
    String id;
    String urlFoto;
    String texto;
    String senha;
    bool aberto;
    String descricao;

    PresenteModel({
        this.id,
        this.urlFoto,
        this.texto,
        this.senha,
        this.aberto,
        this.descricao,
    });

    factory PresenteModel.fromJson(String str) => PresenteModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PresenteModel.fromMap(Map<String, dynamic> json) => PresenteModel(
        id: json["id"],
        urlFoto: json["url_foto"],
        texto: json["texto"],
        senha: json["senha"],
        aberto: json["aberto"],
        descricao: json["descricao"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "url_foto": urlFoto,
        "texto": texto,
        "senha": senha,
        "aberto": aberto,
        "descricao": descricao,
    };
}
