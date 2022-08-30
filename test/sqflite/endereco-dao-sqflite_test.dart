import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testes_unitarios/entity/endereco.dart';
import 'package:testes_unitarios/sqlflite/endereco-dao-sqflite.dart';

void main() {
  late EnderecoDAOSqfLite dao;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    dao = EnderecoDAOSqfLite();
  });

  tearDown(() async {
    String path = join(await getDatabasesPath(), 'banco.db');
    //deleteDatabase(path);
  });

  group('Testes para persistencia de dados', () {
    test('Teste para cadastrar dados no banco', () async {
      var endereco =
          Endereco(cep: '64030670', cidade: 'Teresina', estado: 'PI');
      var resultado = await dao.salvar(endereco);
      expect(resultado, true);
    });

    test('Teste para editar dados no banco', () async {
      var endereco =
          Endereco(cep: '24355150', cidade: 'Niterói', estado: 'RJ', id: 1);
      var resultado = await dao.alterar(endereco);
      expect(resultado, true);
    });

    test('Teste para excluir dados no banco', () async {
      var resultado = await dao.excluir(1);
      expect(resultado, true);
    });
  });

  group('Testes para consulta de registros do banco', () {
    test('Teste para consultar registro no banco', () async {
      var resultado = await dao.consultar(1);
      expect(resultado, isInstanceOf<Endereco>());
    });

    test('Teste para listar dados do banco', () async {
      var resultado = await dao.listar();
      expect(resultado, isInstanceOf<List<Endereco>>());
    });
  });
}
