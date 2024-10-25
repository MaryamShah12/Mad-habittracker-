import 'package:hive/hive.dart';

part 'habit_model.g.dart'; // Add this line for code generation

@HiveType(typeId: 0) // Specify a typeId
class Habit {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int timeGoal;

  @HiveField(3)
  final bool isStarted;

  @HiveField(4)
  final int timeSpent;

  Habit({
    this.id,
    required this.name,
    required this.timeGoal,
    this.isStarted = false,
    this.timeSpent = 0,
  });
}
