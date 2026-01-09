class CreateTaskModel {
  final DateTime dueDate;
  final String? notes;

  CreateTaskModel({
    required this.dueDate,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'dueDate': dueDate.toIso8601String(),
      'notes': notes,
    };
  }
}
