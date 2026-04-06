import 'dart:convert';
import 'package:fluent/model/course_model.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class MockCourseApi {
  List<Course> _courses = [];

  Future<void> loadCourses() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/courses.json',
      );
      final Map<String, dynamic> data = json.decode(response);

      final List<dynamic> coursesJson = data['courses'];
      _courses = coursesJson.map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      Logger().e("Error loading courses from JSON: $e");
      _courses = [];
    }
  }

  Future<T> _simulateDelay<T>(T data, {int ms = 800}) async {
    await Future.delayed(Duration(milliseconds: ms));
    return data;
  }

  Future<List<Course>> getCourses({
    String? category,
    String? level,
    String? search,
  }) async {
    if (_courses.isEmpty) {
      await loadCourses();
    }
    return _simulateDelay(_filterCourses(category, level, search));
  }

  Future<Course> getCourseById(int id) async {
    if (_courses.isEmpty) {
      await loadCourses();
    }
    final course = _courses.firstWhere((c) => c.id == id);
    return _simulateDelay(course);
  }

  List<Course> _filterCourses(String? category, String? level, String? search) {
    List<Course> result = List.from(_courses);

    if (category != null && category.isNotEmpty) {
      result = result
          .where((c) => c.category.toLowerCase() == category.toLowerCase())
          .toList();
    }

    if (level != null && level.isNotEmpty) {
      result = result
          .where((c) => c.level.toLowerCase() == level.toLowerCase())
          .toList();
    }

    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase().trim();
      result = result.where((c) {
        return c.title.toLowerCase().contains(q) ||
            c.description.toLowerCase().contains(q) ||
            c.instructor.toLowerCase().contains(q);
      }).toList();
    }

    return result;
  }
}
