import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_details_app/model/model_db.dart';

class HomeController extends GetxController {
  late final Box<Studentmodel> studentBox;

  final RxList<Studentmodel> students = <Studentmodel>[].obs;

  @override
  void onInit() {
    super.onInit();
    studentBox = Hive.box<Studentmodel>('student_db');
    getStudents();
  }

  Future<void> addStudentToDb(Studentmodel value) async {
    final studentDB = Hive.box<Studentmodel>('student_db');
    await studentDB.add(value);
    Get.snackbar('Success', 'Student detials saved Successfully',
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal);
  }

  void getStudents() {
    students.assignAll(studentBox.values.toList());
    studentBox.watch().listen((event) {
      students.assignAll(studentBox.values.toList());
    });
  }

  void delete(Studentmodel student) {
    studentBox.delete(student.key);
    students.remove(student);
  }

  void updateStudent(Studentmodel student, String name, String age,
      String address, String mobile, imageController) {
    final index = students.indexWhere((s) => s.key == student.key);
    if (index != -1) {
      students[index].name = name;
      students[index].age = age;
      students[index].address = address;
      students[index].mobile = mobile;
      students[index].image = imageController.selectedImage.value!.path;
      imageController.selectedImage.value = null;
      studentBox.put(students[index].key, students[index]);
    }
  }
}
