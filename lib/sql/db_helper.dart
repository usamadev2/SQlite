import 'package:flutter_sqflite/sql/constant.dart';
import 'package:flutter_sqflite/sql/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._init();

  static DBHelper? _dbHelper;
  static Database? _database;

  factory DBHelper() {
    return _dbHelper ??= DBHelper._init();
  }

  Future<Database> _getDB() async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    String dbPath = await getDatabasesPath();
    String filePath = join(dbPath, StudentDBConsts.databaseName);
    return openDatabase(
      filePath,
      version: StudentDBConsts.databaseVersion,
      onCreate: (Database db, int version) {
        db.execute(StudentDBConsts.createTableCommand);
      },
    );
  }

  Future<void> closeDatabase() async {
    Database database = await _getDB();
    await database.close();
  }

  // CRUD OPERATIONS

  // insert / create
  Future<bool> insertStudent(Student student) async {
    Database database = await _getDB();

    int id = await database.insert(StudentDBConsts.tableName, student.toMap());
    return id > 0;
  }

  Future<List<Student>> getStudents() async {
    Database database = await _getDB();

    List<Map<String, Object?>> queryList =
        await database.rawQuery(StudentDBConsts.selectEverythingQuery);
    // List<Student> studentList = [];
    // for (var map in queryList) {
    //   Student student = Student.fromMap(map);
    //   studentList.add(student);
    // }

    // return studentList;
    return queryList.map((map) => Student.fromMap(map)).toList();
  }

// update
  Future<bool> updateStudent(Student student, int id) async {
    Database database = await _getDB();
    int update = await database.update(
      StudentDBConsts.tableName,
      student.toMap(),
      where: '${StudentDBConsts.colId} = ?',
      whereArgs: [id],
    );
    return update > 0;
  }

  Future<bool> deleteStudent(int id) async {
    Database database = await _getDB();
    int rowsEffected = await database.delete(
      StudentDBConsts.tableName,
      where: '${StudentDBConsts.colId} = ?',
      whereArgs: [id],
    );

    return rowsEffected > 0;
  }
}
