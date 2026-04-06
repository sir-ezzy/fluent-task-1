import 'package:fluent/model/course_model.dart';
import 'package:fluent/services/recently_viewed_service.dart';
import 'package:get/get.dart';

class RecentCoursesController extends GetxController {
  final RecentCoursesService _service = RecentCoursesService();

  var recentCourses = <Course>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentCourses();
  }

  Future<void> loadRecentCourses() async {
    isLoading.value = true;
    try {
      await _service.init(); // Ensure box is opened
      recentCourses.value = _service.recentCourses;
    } catch (e) {
      recentCourses.value = [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToRecent(Course course) async {
    await _service.addCourse(course);
    loadRecentCourses(); // Refresh list
  }

  Future<void> clearAllRecent() async {
    await _service.clearAll();
    recentCourses.clear();
  }

  Future<void> removeFromRecent(int courseId) async {
    await _service.removeCourse(courseId);
    loadRecentCourses();
  }
}
