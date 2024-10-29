import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habittracker/util/habit_tile.dart';
import 'package:habittracker/db/database_helper.dart';
import 'package:habittracker/models/habit_model.dart';
import 'package:habittracker/widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Habit> _habitList = [];
  final Map<int, Timer?> _timers = {}; // To store timers for each habit

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

  void _deleteHabit(Habit index) async {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: Text(
            habit == null ? 'Add Habit' : 'Edit Habit',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Habit Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: timeGoalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Time Goal (minutes)', border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (nameController.text.isNotEmpty && timeGoalController.text.isNotEmpty) {
                  final String name = nameController.text;
                  final int timeGoal = int.parse(timeGoalController.text);

                  if (habit == null) {
                    await DatabaseHelper.instance.addHabit(Habit(name: name, timeGoal: timeGoal));
                  } else {
                    await DatabaseHelper.instance.updateHabit(Habit(id: habit.id, name: name, timeGoal: timeGoal));
                  }
                  _loadHabits();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _startStopTimer(int habitId) {
    final habit = _habitList.firstWhere((h) => h.id == habitId);
    if (habit.isStarted) {
      _pauseTimer(habit);
    } else {
      _startTimer(habit);
    }
  }

  void _startTimer(Habit habit) {
    habit.isStarted = true;
    setState(() {}); // Update UI to show timer started
    _timers[habit.id!] = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (habit.timeSpent >= habit.timeGoal * 60) {
        _pauseTimer(habit);
        setState(() {
          habit.isStarted = false;
          habit.timeSpent = habit.timeGoal * 60;
        });
        DatabaseHelper.instance.updateHabit(habit); // Mark as complete in DB
      } else {
        setState(() {
          habit.timeSpent++;
        });
        DatabaseHelper.instance.updateHabit(habit); // Save progress to DB
      }
    });
  }

  void _pauseTimer(Habit habit) {
    habit.isStarted = false;
    _timers[habit.id]?.cancel(); // Stop the timer
    _timers.remove(habit.id);
    setState(() {}); // Update UI to show timer paused
    DatabaseHelper.instance.updateHabit(habit); // Save progress to DB
  }

  @override
  void dispose() {
    _timers.forEach((_, timer) => timer?.cancel());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = screenWidth < 600 ? 16 : 20;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Consistency is Key', style: TextStyle(fontSize: fontSize, color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showHabitDialog(),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.builder(
          itemCount: _habitList.length,
          itemBuilder: (context, index) {
            final habit = _habitList[index];
            return HabitTile(
              habitName: habit.name,
              habitStarted: habit.isStarted,
              timeSpent: habit.timeSpent,
              timeGoal: habit.timeGoal,
              onTap: (){
                setState(() {
                  habit.timeSpent = habit.timeGoal * 60; // Set time spent to goal time in seconds
                  DatabaseHelper.instance.updateHabit(habit);
                });
              },
              onPlayTap: () {
                _startStopTimer(habit.id!);
              },
              settingTapped: () {
                _showHabitDialog(habit: habit);
              },
              onDelete: () {
                print(habit.id);
                _deleteHabit(habit);
              },
              fontSize: fontSize,
            );
          },
        ),
      ),
    );
  }
}
