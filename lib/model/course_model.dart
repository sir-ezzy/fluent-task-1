import 'package:hive/hive.dart';

part 'course_model.g.dart';

@HiveType(typeId: 0)
class Course extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String instructor;
  @HiveField(4)
  final String instructorAvatar;
  @HiveField(5)
  final String category;
  @HiveField(6)
  final String level;
  @HiveField(7)
  final String duration;
  @HiveField(8)
  final double price;
  @HiveField(9)
  final double rating;
  @HiveField(10)
  final int students;
  @HiveField(11)
  final String image;
  @HiveField(12)
  final List<String> tags;
  @HiveField(13)
  final DateTime createdAt;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.instructorAvatar,
    required this.category,
    required this.level,
    required this.duration,
    required this.price,
    required this.rating,
    required this.students,
    required this.image,
    required this.tags,
    required this.createdAt,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      instructorAvatar: json['instructorAvatar'],
      category: json['category'],
      level: json['level'],
      duration: json['duration'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      students: json['students'],
      image: json['image'],
      tags: List<String>.from(json['tags']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
