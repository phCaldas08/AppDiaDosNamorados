import 'package:app_dia_dos_namorados/models/permissao_model.dart';
import 'package:app_dia_dos_namorados/models/presente_model.dart';
import 'package:app_dia_dos_namorados/services/service_config.dart';
import 'package:dio/dio.dart';

class PermissaoService {
  static final String _endpoint =
      "https://5ed1607b4e6d7200163a07fc.mockapi.io/namoradados";
  static final String _resource = 'permissao';

  final ServiceConfig service = new ServiceConfig(_endpoint);

  Future<PermissaoModel> first() async {
    List<PermissaoModel> lista = new List<PermissaoModel>();
    try {
      Response response = await service.create().get(_resource);
      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            lista.add(
              PermissaoModel.fromMap(value),
            );
          },
        );
      }
    } catch (error) {
      throw error;
    }
    return lista.first;
  }


  Future<int> update(PermissaoModel permissaoModel) async {
    try {
      String endpoint = _resource + "/" + permissaoModel.id;
      Response response = await service.create().put(
            endpoint,
            data: permissaoModel.toMap(),
          );
      var retorno = (response.data["id"] is String)
          ? int.parse(response.data["id"])
          : response.data["id"];
      return retorno;
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }
}
