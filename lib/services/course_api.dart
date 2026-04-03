import 'package:fluent/model/course_model.dart';
import 'package:fluent/services/mock_courses.dart';

class MockCourseApi {
  final List<Course> _courses = MockCourses.allCourses;

  Future<T> _simulateDelay<T>(T data, {int ms = 800}) async {
    await Future.delayed(Duration(milliseconds: ms));
    return data;
  }

  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? search,
  }) async {
    return _simulateDelay(_filterCourses(category, level, search));
  }

  Future<Course> getCourseById(int id) async {
    final course = _courses.firstWhere((c) => c.id == id);
    return _simulateDelay(course);
  }

  List<Course> _filterCourses(String? category, String? level, String? search) {
    List<Course> result = List.from(_courses);

    if (category != null) {
      result = result
          .where((c) => c.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    if (level != null) {
      result = result
          .where((c) => c.level.toLowerCase() == level.toLowerCase())
          .toList();
    }
    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      result = result
          .where(
            (c) =>
                c.title.toLowerCase().contains(q) ||
                c.description.toLowerCase().contains(q),
          )
          .toList();
    }
    return result;
  }
}
