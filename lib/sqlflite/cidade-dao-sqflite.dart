import 'package:sqflite/sqflite.dart';
import 'package:testes_unitarios/entity/cidade.dart';

import 'conexao.dart';

class CidadeDAOSqflite {
  Future<bool> salvar(Cidade cidade) async {
    Database db = await Conexao.abrir();
    const sql = 'INSERT INTO cidade (municipio, estado, pais) VALUES (?,?,?)';
    var linhasAfetadas =
        await db.rawInsert(sql, [cidade.municipio, cidade.estado, cidade.pais]);
    return linhasAfetadas > 0;
  }

  Future<bool> alterar(Cidade cidade) async {
    const sql = 'UPDATE cidade SET municipio=?, estado=?, pais=? WHERE id = ?';
    Database db = await Conexao.abrir();
    var linhasAfetadas = await db.rawUpdate(
        sql, [cidade.municipio, cidade.estado, cidade.pais, cidade.id]);
    return linhasAfetadas > 0;
  }

  Future<bool> excluir(int id) async {
    late Database db;
    try {
      const sql = 'DELETE FROM cidade WHERE id = ?';
      db = await Conexao.abrir();
      int linhasAfetadas = await db.rawDelete(sql, [id]);
      return linhasAfetadas > 0;
    } catch (e) {
      throw Exception('Ocorreu um erro ao excluir o registro $id');
    } finally {
      db.close();
    }
  }

  Future<Cidade> consultar(int id) async {
    late Database db;
    try {
      const sql = 'SELECT * FROM cidade WHERE id = ?';
      db = await Conexao.abrir();
      Map<String, Object?> resultado = (await db.rawQuery(sql, [id])).first;
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro de id $id encontrado!');
      }
      Cidade cidade = Cidade(
          id: resultado['id'] as int,
          municipio: resultado['municipio'].toString(),
          estado: resultado['estado'].toString(),
          pais: resultado['pais'].toString());
      return cidade;
    } catch (e) {
      throw Exception('Não foi possível retornar a consulta do registro $id');
    } finally {
      db.close();
    }
  }

  @override
  Future<List<Cidade>> listar() async {
    late Database db;
    try {
      const sql = 'SELECT * FROM cidade';
      db = await Conexao.abrir();
      List<Map<String, Object?>> resultado = (await db.rawQuery(sql));
      if (resultado.isEmpty) {
        throw Exception('Nenhum registro foi encontrado!');
      }
      List<Cidade> cidades = resultado.map((linha) {
        return Cidade(
            id: linha['id'] as int,
            municipio: linha['municipio'].toString(),
            estado: linha['estado'].toString(),
            pais: linha['pais'].toString());
      }).toList();
      return cidades;
    } catch (e) {
      throw Exception(
          'Ocorreu um erro os listar os registros cadastrados no banco!');
    } finally {
      db.close();
    }
  }
}
