import 'task_status.dart';

class UpdateTaskModel {
  final int taskId;
  final DateTime dueDate;
  String? notes;
  final TaskStatus status;

  UpdateTaskModel({
    required this.taskId,
    required this.dueDate,
    this.notes,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'dueDate': dueDate.toIso8601String(),
      'notes': notes,
      'status': status.name,
    };
  }
}
