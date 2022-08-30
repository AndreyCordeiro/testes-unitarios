import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Funcoes {
  Future<bool> verificarSeCepExiste(String cep) async {
    var dio = Dio();

    final Response response =
        await dio.get('https://viacep.com.br/ws/64004-015/json');
    debugPrint(response.data);

    return response.statusCode == 200;
  }

  bool validarCep(String cep) {
    return cep.length == 8;
  }

  bool validarEndereco(String endereco) {
    return !(endereco.isEmpty || endereco == '');
  }
}
