import 'package:fluent/model/course_model.dart';
import 'package:fluent/services/course_api.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CourseController extends GetxController {
  final MockCourseApi _api = MockCourseApi();
  var courseList = <Course>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses({String? category, String? search}) async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final courses = await _api.getCourses(category: category, search: search);
      courseList.value = courses;
    } catch (e) {
      errorMessage.value = "Failed to load courses";
      Logger().e("Error fetching courses: $e");
      Get.snackbar("Error", errorMessage.value);
    } finally {
      isLoading.value = false;
    }
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
