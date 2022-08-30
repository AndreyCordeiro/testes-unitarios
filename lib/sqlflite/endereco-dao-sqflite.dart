import 'package:sqflite/sqflite.dart';

import '../entity/endereco.dart';
import 'conexao.dart';

class EnderecoDAOSqfLite {
  Future<bool> salvar(Endereco endereco) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO endereco (cep, cidade, estado) VALUES (?,?,?)';
    var linhasAfetadas = await db
        .rawInsert(sql, [endereco.cep, endereco.cidade, endereco.estado]);
    return linhasAfetadas > 0;
  }

  Future<bool> alterar(Endereco endereco) async {
    const sql = 'UPDATE endereco SET cep=?, cidade=?, estado=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
        sql, [endereco.cep, endereco.cidade, endereco.estado, endereco.id]);
    return linhasAfetadas > 0;
  }

  Future<bool> excluir(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM endereco WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      db.close();
    }
  }

  Future<Endereco> consultar(int id) async {
    late Database db;
    try {
      const sql = 'SELECT * FROM endereco WHERE id = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }
      Endereco endereco = Endereco(
          id: resultado['id'] as int,
          cep: resultado['cep'].toString(),
          cidade: resultado['cidade'].toString(),
          estado: resultado['estado'].toString());
      return endereco;
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      db.close();
    }
  }

  @override
  Future<List<Endereco>> listar() async {
    late Database db;
    try {
      const sql = 'SELECT * FROM endereco';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }
      List<Endereco> enderecos = resultado.map((linha) {
        return Endereco(
            id: linha['id'] as int,
            cep: linha['cep'].toString(),
            cidade: linha['cidade'].toString(),
            estado: linha['estado'].toString());
      }).toList();
      return enderecos;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      db.close();
    }
  }
}
