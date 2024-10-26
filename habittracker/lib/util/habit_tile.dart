import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitStarted;
  final int timeSpent;
  final int timeGoal;
  final Function()? onTap;
  final Function()? settingTapped;
  final Function()? onDelete;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitStarted,
    required this.timeSpent,
    required this.timeGoal,
    this.onTap,
    this.settingTapped,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habitName),
      subtitle: Text('Time Goal: $timeGoal minutes, Time Spent: $timeSpent minutes'),
      trailing: Wrap(
        spacing: 12,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: settingTapped,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
