// lib/models/program.dart
class Program {
  final String id;
  final String title;
  final String company;
  final String location;
  final String type;
  final String duration;
  final String salary;
  final String description;

  const Program({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.type,
    required this.duration,
    required this.salary,
    required this.description,
  });
}