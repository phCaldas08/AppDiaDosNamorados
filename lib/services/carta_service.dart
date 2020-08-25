import 'package:app_dia_dos_namorados/models/carta_model.dart';
import 'package:app_dia_dos_namorados/models/presente_model.dart';
import 'package:app_dia_dos_namorados/services/service_config.dart';
import 'package:dio/dio.dart';

class CartaService {
  static final String _endpoint =
      "https://5ed1607b4e6d7200163a07fc.mockapi.io/namoradados";
  static final String _resource = 'carta';

  final ServiceConfig service = new ServiceConfig(_endpoint);

  Future<CartaModel> first() async {
    List<CartaModel> lista = new List<CartaModel>();
    try {
      Response response = await service.create().get(_resource);
      if (response.statusCode == 200) {
        response.data.forEach(
          (value) {
            lista.add(
              CartaModel.fromMap(value),
            );
          },
        );
      }
    } catch (error) {
      throw error;
    }
    return lista.first;
  }
}
