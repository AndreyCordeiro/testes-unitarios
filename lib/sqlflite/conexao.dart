import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static Database? _conexao;
  static const String _criarEndereco =
      'CREATE TABLE endereco(id INTEGER PRIMARY KEY, cep TEXT, cidade TEXT, estado TEXT)';

  static const String _insercao1 =
      'INSERT INTO endereco(cep, cidade, estado) VALUES("64030670","Teresina","PI")';

  static Future<Database> abrir() async {
    if (_conexao == null) {
      String path = join(await getDatabasesPath(), 'banco.db');
      deleteDatabase(path);
      _conexao = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          db.execute(_criarEndereco);
          db.execute(_insercao1);
        },
      );
    }
    return _conexao!;
  }
}
