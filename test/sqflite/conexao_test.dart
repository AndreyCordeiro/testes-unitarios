import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:testes_unitarios/sqlflite/conexao.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  late Database db;

  setUp(() async {
    String path = join(await getDatabasesPath(), 'banco.db');
    //deleteDatabase(path);
    db = await Conexao.abrir();
  });

  tearDownAll(() {
    db.close();
  });

  group("Teste conexão banco", () {
    test("Verifica se a conexão com o banco está aberta", () async {
      expect(db.isOpen, true);
    });
  });
}
