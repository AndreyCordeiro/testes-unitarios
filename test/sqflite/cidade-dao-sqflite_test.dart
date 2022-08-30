import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testes_unitarios/entity/cidade.dart';
import 'package:testes_unitarios/sqlflite/cidade-dao-sqflite.dart';

void main() {
  late CidadeDAOSqflite dao;
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUp(() async {
    dao = CidadeDAOSqflite();
  });

  tearDown(() async {
    String path = join(await getDatabasesPath(), 'banco.db');
    // deleteDatabase(path);
  });

  group('Testes para persistencia de dados', () {
    test('Teste para cadastrar dados no banco', () async {
      var cidade = Cidade(municipio: 'Paranavai', estado: 'PR', pais: 'BR');
      var resultado = await dao.salvar(cidade);
      expect(resultado, true);
    });

    test('Teste para editar dados no banco', () async {
      var cidade =
          Cidade(municipio: 'Paranavai', estado: 'PR', pais: 'BR', id: 1);
      var resultado = await dao.alterar(cidade);
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
      expect(resultado, isInstanceOf<Cidade>());
    });

    test('Teste para listar dados do banco', () async {
      var resultado = await dao.listar();
      expect(resultado, isInstanceOf<List<Cidade>>());
    });
  });
}
