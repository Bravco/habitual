// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Model
import 'package:app/model/habit.dart';

class HabitsDatabase {
  static final HabitsDatabase instance = HabitsDatabase._init();

  static Database? _database;

  HabitsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("habits.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const titleType = "TEXT NOT NULL";
    const subtitleType = "TEXT";
    const dateDataType = "TEXT";

    await db.execute('''
CREATE TABLE $tableHabits (
  ${HabitFields.id} $idType,
  ${HabitFields.title} $titleType,
  ${HabitFields.subtitle} $subtitleType,
  ${HabitFields.dateData} $dateDataType
  )
''');
  }

  Future<Habit> create(Habit habit) async {
    final db = await instance.database;

    final id = await db.insert(tableHabits, habit.toJson());

    return habit.copy(id: id);
  }

  Future<Habit> readHabit(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHabits,
      columns: HabitFields.values,
      where: "${HabitFields.id} = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Habit.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<List<Habit>> readAllHabits() async {
    final db = await instance.database;

    final result = await db.query(tableHabits);

    return result.map((json) => Habit.fromJson(json)).toList();
  }

  Future<int> update(Habit habit) async {
    final db = await instance.database;

    return db.update(
      tableHabits,
      habit.toJson(),
      where: "${HabitFields.id} = ?",
      whereArgs: [habit.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableHabits,
      where: "${HabitFields.id} = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}