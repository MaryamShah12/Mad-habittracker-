import 'package:flutter/material.dart';
import 'package:habittracker/db/database_helper.dart';
import 'package:habittracker/models/habit_model.dart';

class AddEditHabit extends StatefulWidget {
  final Habit? habit;

  const AddEditHabit({Key? key, this.habit}) : super(key: key);

  @override
  _AddEditHabitState createState() => _AddEditHabitState();
}

class _AddEditHabitState extends State<AddEditHabit> {
  final _formKey = GlobalKey<FormState>();
  late String _habitName;
  late int _timeGoal;

  @override
  void initState() {
    super.initState();
    _habitName = widget.habit?.name ?? '';
    _timeGoal = widget.habit?.timeGoal ?? 0;
  }

  void _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.habit == null) {
        await DatabaseHelper.instance.addHabit(
          Habit(name: _habitName, timeGoal: _timeGoal),
        );
        print('Habit saved: $_habitName');
      } else {
        await DatabaseHelper.instance.updateHabit(
          Habit(
            id: widget.habit!.id,
            name: _habitName,
            timeGoal: _timeGoal,
          ),
        );
        print('Habit updated: $_habitName');
      }
      Navigator.pop(context, true);
    } else {
      print('Form is not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.habit == null ? 'Add Habit' : 'Edit Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _habitName,
                decoration: const InputDecoration(labelText: 'Habit Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _habitName = value!;
                },
              ),
              TextFormField(
                initialValue: _timeGoal.toString(),
                decoration: const InputDecoration(labelText: 'Time Goal (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time goal';
                  }
                  return null;
                },
                onSaved: (value) {
                  _timeGoal = int.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveHabit,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}