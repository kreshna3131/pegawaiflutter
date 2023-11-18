import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pegawai/model/employee.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'employees.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT,
        last_name TEXT,
        mobile_no TEXT
      )
    ''');
  }

  // Future<void> saveEmployee(Employee employee) async {
  //   final db = await database;
  //   await db.insert('employees', employee.toMap());
  // }

  Future<void> saveEmployee(Employee employee) async {
    final db = await database;
    if (employee.id == null) {
      // Insert new employee
      await db.insert('employees', employee.toMap());
    } else {
      // Update existing employee
      await db.update(
        'employees',
        employee.toMap(),
        where: 'id = ?',
        whereArgs: [employee.id],
      );
    }
  }

  Future<List<Employee>> getEmployees() async {
    final db = await database;
    var result = await db.query('employees');
    return result.map((e) => Employee.fromMap(e)).toList();
  }

  Future<void> deleteEmployee(int id) async {
    final db = await database;
    await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}
