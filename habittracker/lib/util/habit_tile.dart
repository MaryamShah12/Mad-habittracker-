import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitStarted;
  final int timeSpent;
  final int timeGoal;
  final Function onTap;
  final Function settingTapped;
  final Function onDelete;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitStarted,
    required this.timeSpent,
    required this.timeGoal,
    required this.onTap,
    required this.settingTapped,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(habitName),
      subtitle: Text('Goal: $timeGoal minutes, Spent: $timeSpent minutes'),
      onTap: () => onTap(),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => settingTapped(),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(),
          ),
        ],
      ),
    );
  }
}
