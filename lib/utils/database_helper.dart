import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'expenses.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses(
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL
      )
    ''');
    print('Database created successfully');
  }

  // Insert a new expense
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    final result = await db.insert(
      'expenses',
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Expense inserted with ID: ${expense.id}');
    return result;
  }

  // Get all expenses
  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      orderBy: 'date DESC',
    );
    
    print('Loaded ${maps.length} expenses from database');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  // Delete an expense by ID
  Future<int> deleteExpense(String id) async {
    final db = await database;
    final result = await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Expense deleted with ID: $id');
    return result;
  }

  // Get total expenses amount
  Future<double> getTotalExpenses() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM expenses');
    final total = result.first['total'] as double?;
    return total ?? 0.0;
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}