enum TaskStatus {
  Pending,
  InProgress,
  Completed,
  Cancelled
}

TaskStatus taskStatusFromString(String value) {
  return TaskStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == value.toLowerCase(),
  );
}

String taskStatusToString(TaskStatus status) {
  return status.name;
}
