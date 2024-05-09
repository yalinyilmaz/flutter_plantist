class TodoModel {
  String title;
  String? note;
  String priority;
  String dueDate;
  String dueTime;

  TodoModel({
    required this.title,
    this.note,
    required this.priority,
    required this.dueDate,
    required this.dueTime,
  });
}
