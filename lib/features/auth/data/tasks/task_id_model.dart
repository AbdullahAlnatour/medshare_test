class TaskIdModel {
  final int taskId;

  TaskIdModel({required this.taskId});

  Map<String, dynamic> toJson() {
    return {'taskId': taskId};
  }
}
