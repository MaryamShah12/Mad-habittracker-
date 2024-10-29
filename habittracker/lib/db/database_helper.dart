import 'dart:math';

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
    int id = Random().nextInt(1000);
    habit.id = id;
    print(habit.id);
    final box = await habitBox;
    await box.put(habit.id, habit);
  }

  Future<void> updateHabit(Habit habit) async {
    final box = await habitBox;
    await box.put(habit.id!, habit);
  }

  Future<void> deleteHabit(Habit habit) async {
      final box = await habitBox;
      await box.delete(habit.id);

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