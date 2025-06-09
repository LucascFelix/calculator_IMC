// usuario_dao.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:prjimc/model/usuario.dart';

class UsuarioDao {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'usuarios.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE usuarios(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            sobrenome TEXT,
            email TEXT UNIQUE,
            senha TEXT
          )
        ''');
      },
    );
  }

  Future<int> inserirUsuario(Usuario usuario) async {
    final db = await database;
    return await db.insert('usuarios', usuario.toMap());
  }

  Future<Usuario?> buscarUsuarioPorEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'usuarios',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return Usuario.fromMap(maps.first);
    }
    return null;
  }

  
}
