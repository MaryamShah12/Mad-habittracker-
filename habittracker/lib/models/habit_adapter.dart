import 'package:hive/hive.dart';
import 'habit_model.dart';

part 'habit_adapter.g.dart';

@HiveType(typeId: 0)
class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    return Habit(
      id: reader.read() as int?,
      name: reader.read() as String,
      timeGoal: reader.read() as int,
      isStarted: reader.read() as bool,
      timeSpent: reader.read() as int,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer.write(obj.id);
    writer.write(obj.name);
    writer.write(obj.timeGoal);
    writer.write(obj.isStarted);
    writer.write(obj.timeSpent);
  }
}
