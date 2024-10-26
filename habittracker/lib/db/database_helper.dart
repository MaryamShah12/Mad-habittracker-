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

  Future<void> addHabit(Habit habit) async {
    final box = await habitBox;
    await box.add(habit);
  }

  Future<void> updateHabit(Habit habit) async {
    final box = await habitBox;
    await box.put(habit.id!, habit);
  }

  Future<void> deleteHabit(int index) async {
    final box = await habitBox;
    await box.deleteAt(index);
  }

  Future<List<Habit>> getHabits() async {
    final box = await habitBox;
    return box.values.toList();
  }

  Future<void> close() async {
    final box = await habitBox;
    await box.close();
  }
}


