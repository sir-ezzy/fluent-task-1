import 'package:fluent/model/course_model.dart';
import 'package:hive/hive.dart';

class RecentCoursesService {
  static const String boxName = 'recentCourses';

  static final RecentCoursesService _instance =
      RecentCoursesService._internal();
  factory RecentCoursesService() => _instance;
  RecentCoursesService._internal();

  late Box<Course> _box;

  Future<void> init() async {
    _box = await Hive.openBox<Course>(boxName);
  }

  List<Course> get recentCourses => _box.values.toList().reversed.toList();

  Future<void> addCourse(Course course) async {
    // Remove duplicate if exists
    final existingKeys = _box.keys.where((key) {
      final existing = _box.get(key);
      return existing?.id == course.id;
    });

    for (var key in existingKeys) {
      await _box.delete(key);
    }

    // Add new course
    await _box.put(course.id, course);

    // Keep only latest 10 courses
    if (_box.length > 10) {
      final keysToRemove = _box.keys.take(_box.length - 10).toList();
      for (var key in keysToRemove) {
        await _box.delete(key);
      }
    }
  }

  Future<void> clearAll() async => await _box.clear();

  Future<void> removeCourse(int courseId) async => await _box.delete(courseId);
}
