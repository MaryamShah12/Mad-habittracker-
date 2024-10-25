import 'package:hive/hive.dart';
import '../models/habit_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  Box<Habit>? _habitBox;

  DatabaseHelper._init();

  Future<Box<Habit>> get habitBox async {
    if (_habitBox != null) return _habitBox!;
    _habitBox = await Hive.openBox<Habit>('habits');
    return _habitBox!;
  }

  // Add a habit to the database
  Future<void> addHabit(Habit habit) async {
    final box = await habitBox;
    await box.add(habit); // Automatically generates an id
  }

  // Update an existing habit
  Future<void> updateHabit(Habit habit) async {
    final box = await habitBox;
    await box.put(habit.id!, habit); // Use the id as the key
  }

  // Delete a habit by index
  Future<void> deleteHabit(int index) async {
    final box = await habitBox;
    await box.deleteAt(index);
  }

  // Retrieve all habits
  Future<List<Habit>> getHabits() async {
    final box = await habitBox;
    return box.values.toList();
  }

  // Close the database
  Future<void> close() async {
    final box = await habitBox;
    await box.close();
  }
}


