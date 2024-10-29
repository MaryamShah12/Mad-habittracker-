import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int timeGoal;

  @HiveField(3)
  bool isStarted;

  @HiveField(4)
  int timeSpent;

  Habit({
    this.id,
    required this.name,
    required this.timeGoal,
    this.isStarted = false,
    this.timeSpent = 0,
  });
}