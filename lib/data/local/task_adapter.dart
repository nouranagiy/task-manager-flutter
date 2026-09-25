import 'package:hive/hive.dart';
import '../../models/task_model.dart';

class TaskAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;
  @override
  TaskModel read(BinaryReader reader) {
    return TaskModel(
      id: reader.readString(),
      title: reader.readString(),
      description: reader.readString(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      dueDate: reader.readBool()
          ? DateTime.fromMillisecondsSinceEpoch(reader.readInt())
          : null,
      isCompleted: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    if (obj.dueDate != null) {
      writer.writeBool(true);
      writer.writeInt(obj.dueDate!.millisecondsSinceEpoch);
    } else {
      writer.writeBool(false);
    }
    writer.writeBool(obj.isCompleted);
  }
}
