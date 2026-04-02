class Course {
  final int id;
  final String title;
  final String description;
  final String instructor;
  final String instructorAvatar;
  final String category;
  final String level;
  final String duration;
  final double price;
  final double rating;
  final int students;
  final String image;
  final List<String> tags;
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'instructor': instructor,
      'instructorAvatar': instructorAvatar,
      'category': category,
      'level': level,
      'duration': duration,
      'price': price,
      'rating': rating,
      'students': students,
      'image': image,
      'tags': tags,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
