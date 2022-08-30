import 'package:flutter_test/flutter_test.dart';

import '../lib/funcoes.dart';

void main() {
  var cep;
  var cpf;
  var endereco;

  setUp(() {
    cep = '64004015';
    cpf = '56984525458';
    endereco = 'Rua Marechal Candido Rondom';
  });

  group("Testes para a entidade Endereço", () {
    test("Validar se o Endereço é nulo ou é uma string vazia", () {
      expect(Funcoes().validarEndereco(endereco), true);
    });

    test("Verificar se o CEP existe", () {
      expect(Funcoes().verificarSeCepExiste(cep), true);
    });

    test("Validar se o CEP é válido", () {
      expect(Funcoes().validarCep(cep), true);
    });
  });
}
