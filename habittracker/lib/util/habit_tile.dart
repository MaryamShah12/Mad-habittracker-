import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitStarted;
  final int timeSpent; // In seconds for better formatting
  final int timeGoal;
  final Function()? onPlayTap;
  final Function()? settingTapped;
  final Function()? onDelete;
  final double fontSize;
  final VoidCallback onTap;

  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitStarted,
    required this.timeSpent,
    required this.timeGoal,
    this.onPlayTap,
    this.settingTapped,
    this.onDelete,
    required this.fontSize, required this.onTap,
  }) : super(key: key);

  String formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isGoalReached = timeSpent >= timeGoal * 60; // Convert minutes to seconds
    final timerDisplay = formatTime(timeSpent);

    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: isGoalReached ? Colors.green[100] : Colors.white, // Highlight green if goal reached
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: ListTile(
            title: Text(
              habitName,
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            subtitle: Text(
              'Goal: ${timeGoal}m | Spent: $timerDisplay',
              style: TextStyle(fontSize: fontSize * 0.8, color: Colors.grey[700]),
            ),
            trailing: Wrap(
              spacing: 8,
              children: <Widget>[
                IconButton(
                  icon: Icon(habitStarted ? Icons.pause : Icons.play_arrow, color: habitStarted ? Colors.red : Colors.green),
                  onPressed: onPlayTap,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: settingTapped,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}