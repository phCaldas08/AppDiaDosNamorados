// To parse this JSON data, do
//
//     final cartaModel = cartaModelFromJson(jsonString);

import 'dart:convert';

class CartaModel {
    String id;
    String titulo;
    String texto;

    CartaModel({
        this.id,
        this.titulo,
        this.texto,
    });

    factory CartaModel.fromJson(String str) => CartaModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory CartaModel.fromMap(Map<String, dynamic> json) => CartaModel(
        id: json["id"],
        titulo: json["titulo"],
        texto: json["texto"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "texto": texto,
    };
}
