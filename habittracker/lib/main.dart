import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habittracker/models/habit_model.dart' as model;
import 'package:habittracker/models/habit_adapter.dart' as adapter;
import 'package:habittracker/models/user_model.dart';
import 'login_page.dart';

void main() async {
  await Hive.deleteFromDisk();
  await Hive.initFlutter();
  Hive.registerAdapter(adapter.HabitAdapter());
  Hive.registerAdapter(UserAdapter());  // Register User adapter
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}



