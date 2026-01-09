enum TasksStatus {
  Pending,
  Cancelled,
  Completed,
}

class TaskResponseModel {
  final int taskId;
  final DateTime dueDate;
  String? notes;
  final TasksStatus status;

  TaskResponseModel({
    required this.taskId,
    required this.dueDate,
    this.notes,
    required this.status,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskResponseModel(
      taskId: json['taskId'],
      dueDate: DateTime.parse(json['dueDate']),
      notes: json['notes'],
      status: TasksStatus.values.firstWhere(
            (e) =>
        e.name.toLowerCase() ==
            json['status']?.toString().toLowerCase(),
        orElse: () => TasksStatus.Pending, // قيمة افتراضية
      ),
    );
  }

}
