import 'package:loginsql/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('user.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableUser ( 
  ${UserFields.id} $idType, 
  ${UserFields.gmail} $textType,
  ${UserFields.name} $textType,
  ${UserFields.pass} $textType
  )
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<User> readUser2(User user) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUser,
      columns: UserFields.values,
      where: '${UserFields.gmail} = ?',
      whereArgs: [user.gmail],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<User>> readAllUser() async {
    final db = await instance.database;

    final orderBy = '${UserFields.name} ASC';

    final result = await db.query(tableUser, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update(User user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
