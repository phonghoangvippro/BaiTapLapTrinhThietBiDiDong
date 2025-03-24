import 'dart:ui';

class Task {
  String title;
  String description;
  String status;
  String date;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.isCompleted,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      status: json['status'] ?? 'Pending',
      date: json['date'] ?? 'No Date',
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  /// Trả về màu cố định theo thứ tự: Hồng → Vàng → Xanh
  Color getBackgroundColor(int index) {
    List<Color> colors = [
      const Color(0xFFE1BBC1), // Hồng (Task 1)
      const Color(0xFFDDE2B6), // Vàng (Task 2)
      const Color(0xFFB7E9FF), // Xanh (Task 3)
    ];
    return colors[index % colors.length]; // Lặp lại thứ tự
  }
}
