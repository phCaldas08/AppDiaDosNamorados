
import 'dart:convert';

class PermissaoModel {
    String id;
    bool permitido;
    String senha;

    PermissaoModel({
        this.id,
        this.permitido,
        this.senha,
    });

    factory PermissaoModel.fromJson(String str) => PermissaoModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PermissaoModel.fromMap(Map<String, dynamic> json) => PermissaoModel(
        id: json["id"],
        permitido: json["permitido"],
        senha: json["senha"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "permitido": permitido,
        "senha": senha,
    };
}
