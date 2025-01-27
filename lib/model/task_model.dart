class Task {
  final String id;
  final String text;
  bool isCompleted;

  Task({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });
}
