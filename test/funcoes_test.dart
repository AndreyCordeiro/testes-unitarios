import 'package:flutter_test/flutter_test.dart';

import '../lib/funcoes.dart';

void main() {
  var nome;
  var cpf;
  var idade;

  setUp(() {
    nome = 'Matheus';
    cpf = '56984525458';
    idade = 120;
  });

  group("Testes para a entidade Cliente", () {
    test("Validar se a idade é menor que 130", () {
      expect(Funcoes().verificarIdade(idade), true);
    });

    test("Verificar tamanho do nome", () {
      expect(Funcoes().verificarTamanhoNome(nome), 7);
    });

    test("Validar o tamanho do CPF", () {
      expect(Funcoes().verificarTamanhoCpf(cpf), 11);
    });
  });
}
