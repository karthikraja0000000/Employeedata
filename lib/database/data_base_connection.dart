import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';

class DataBaseHelper {
  static Database? _database;
  static final DataBaseHelper instance = DataBaseHelper._init();

  DataBaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db', 1);
    return _database!;
  }

  Future<Database> _initDB(String dbname, int i) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbname);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(String email, String password, String username) async {
    final db = await database;

    // Check if the user already exists
    final List<Map<String, dynamic>> existingUser = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      print("User already exists");
      return -1;
    }

    try {
      return await db.insert('users', {
        'email': email,
        'password': password,
        'username': username,
      }, conflictAlgorithm: ConflictAlgorithm.fail);
    } catch (e) {
      print("Error inserting user: $e");
      return -1;
    }
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;

    final allUsers = await db.query('users');
    print("All users in DB: $allUsers");

    final result = await db.query(
      'users',
      columns: ['id', 'username', 'email'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    print(result);
    return result.isNotEmpty ? result.first : null;
  }

  Future createUserTable(String email) async {
    final db = await database;
    String tableName = email.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE NOT NULL,
    age INTEGER NOT NULL
     )
    ''');

    print(tableName);

  }

  Future<int> insertUserTable( String email,String name, String age,) async {
    final db = await database;
    String tableName = email.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

    try {
      print(tableName);
         return await db.insert(tableName, {
        "name": name,
        "age": age,

      }, conflictAlgorithm: ConflictAlgorithm.replace);

    } catch (e) {
      print("error inserting data: $e");
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers(String email) async {
    final db = await database;
    String tableName = email.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
    return await db.query(tableName);
  }

  Future<int> deleteUser(int id, String email) async {
    final db = await database;
    String tableName = email.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

    return await db.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id]);
  }
  Future<int> updateUser(int id, String name, String age,String email) async {
    final db = await database;
    String tableName = email.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

    try{
      return await db.update(
        tableName,
        {'name': name, 'age': age},
        where: 'id = ?',
        whereArgs: [id],
      );
    }catch(e){
      print("error inserting data: $e");
      return -1;
    }
  }
}
