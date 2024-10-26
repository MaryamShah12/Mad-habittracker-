import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habittracker/models/habit_model.dart' as model; // Import with prefix
import 'package:habittracker/models/habit_adapter.dart' as adapter; // Import with prefix
import 'home_page.dart';

void main() async {
  await Hive.deleteFromDisk(); // Clear existing data

  await Hive.initFlutter();
  Hive.registerAdapter(adapter.HabitAdapter()); // Register the HabitAdapter using prefix
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

