import 'package:flutter/material.dart';
import 'package:habittracker/util/habit_tile.dart';
import 'package:habittracker/db/database_helper.dart';
import 'package:habittracker/models/habit_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habit> _habitList = [];

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habits = await DatabaseHelper.instance.getHabits();
    setState(() {
      _habitList = habits;
    });
  }

  void _deleteHabit(int index) async {
    await DatabaseHelper.instance.deleteHabit(index);
    _loadHabits();
  }

  Future<void> _showHabitDialog({Habit? habit}) async {
    final TextEditingController nameController = TextEditingController(text: habit?.name ?? '');
    final TextEditingController timeGoalController = TextEditingController(text: habit?.timeGoal.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(habit == null ? 'Add Habit' : 'Edit Habit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: timeGoalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Time Goal (minutes)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isNotEmpty && timeGoalController.text.isNotEmpty) {
                  final String name = nameController.text;
                  final int timeGoal = int.parse(timeGoalController.text);

                  if (habit == null) {
                    await DatabaseHelper.instance.addHabit(
                      Habit(name: name, timeGoal: timeGoal),
                    );
                  } else {
                    await DatabaseHelper.instance.updateHabit(
                      Habit(id: habit.id, name: name, timeGoal: timeGoal),
                    );
                  }
                  _loadHabits(); // Refresh the habit list
                  Navigator.pop(context); // Close dialog
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text('Consistency is Key'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showHabitDialog(), // Open dialog to add a new habit
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _habitList.length,
        itemBuilder: (context, index) {
          final habit = _habitList[index];
          return HabitTile(
            habitName: habit.name,
            habitStarted: habit.isStarted,
            timeSpent: habit.timeSpent,
            timeGoal: habit.timeGoal,
            onTap: () {
              // Start/Stop habit timer logic here
            },
            settingTapped: () {
              _showHabitDialog(habit: habit); // Open dialog to edit the habit
            },
            onDelete: () {
              _deleteHabit(index); // Use index for deletion
            },
          );
        },
      ),
    );
  }
}
