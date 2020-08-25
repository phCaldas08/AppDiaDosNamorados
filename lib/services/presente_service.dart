import 'package:app_dia_dos_namorados/models/presente_model.dart';
import 'package:app_dia_dos_namorados/services/service_config.dart';
import 'package:dio/dio.dart';

class PresenteService {
  static final String _endpoint =
      "https://5ed1607b4e6d7200163a07fc.mockapi.io/namoradados";
  static final String _resource = 'presentes';

  final ServiceConfig service = new ServiceConfig(_endpoint);

  Future<List<PresenteModel>> findAll() async {
    List<PresenteModel> lista = new List<PresenteModel>();
    try {
      Response response = await service.create().get(_resource);
      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            lista.add(
              PresenteModel.fromMap(value),
            );
          },
        );
      }
    } catch (error) {
      throw error;
    }
    return lista;
  }

  Future<PresenteModel> getById(int id) async {
    try {
      String endpoint = _resource + "/" + id.toString();
      Response response = await service.create().get(endpoint);

      if (response.statusCode == 200) {
        var retorno = PresenteModel.fromMap(response.data);
        return retorno;
      }
    } catch (error) {
      print("Service Error: $error ");
      throw error;
    }
  }


  Future<int> update(PresenteModel presenteModel) async {
    try {
      String endpoint = _resource + "/" + presenteModel.id;
      Response response = await service.create().put(
            endpoint,
            data: presenteModel.toMap(),
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
