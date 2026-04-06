import 'package:fluent/model/course_model.dart';
import 'package:fluent/services/course_api_service.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CourseController extends GetxController {
  final MockCourseApi _api = MockCourseApi();
  var courseList = <Course>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  List<Course> get filteredCourses {
    if (searchQuery.value.trim().isEmpty) {
      return courseList;
    }

    final query = searchQuery.value.toLowerCase().trim();

    return courseList.where((course) {
      return course.title.toLowerCase().contains(query) ||
          course.instructor.toLowerCase().contains(query) ||
          course.category.toLowerCase().contains(query);
    }).toList();
  }

  // Fetch all courses from JSON
  Future<void> fetchCourses() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final courses = await _api.getCourses();
      courseList.value = courses;
    } catch (e) {
      errorMessage.value = "Failed to load courses";
      Logger().e("Error fetching courses: $e");
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  void searchCourses(String query) {
    searchQuery.value = query;
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  Future<Course?> getCourseDetail(int id) async {
    try {
      return await _api.getCourseById(id);
    } catch (e) {
      Logger().e("Error fetching course detail: $e");
      Get.snackbar("Error", "Course not found");
      return null;
    }
  }
}
