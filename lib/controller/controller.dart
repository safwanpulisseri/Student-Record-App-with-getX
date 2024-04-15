import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_details_app/model/model_db.dart';

ValueNotifier<List<Studentmodel>> studentlistNotifier = ValueNotifier([]);

late Database _db;

Future<void> initializeDatabase() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student(id INTEGER PRIMARY KEY ,name TEXT,age TEXT,address TEXT,mobile TEXT,image TEXT)');
  });

  // Retrieve data from the database during initialization
  getAllStudents();
}

Future<void> addStudent(Studentmodel value) async {
  await _db.rawInsert(
      'INSERT INTO student(name,age,address,mobile,image)VALUES(?,?,?,?,?)',
      [value.name, value.age, value.address, value.mobile, value.image]);
  getAllStudents();
}

Future<void> getAllStudents() async {
  final values = await _db.rawQuery('SELECT * FROM student');
  studentlistNotifier.value.clear();
  for (var map in values) {
    final student = Studentmodel.fromMap(map);
    studentlistNotifier.value.add(student);
  }
  studentlistNotifier.notifyListeners();
}

Future<void> deleteStudent(int id) async {
  await _db.delete("student", where: "id=?", whereArgs: [id]);
  getAllStudents();
}

Future<void> updateStudent(int id, String name, String age, String address,
    String mobile, String image) async {
  final data = {
    'name': name,
    'age': age,
    'address': address,
    'mobile': mobile,
    'image': image
  };
  await _db.update("student", data, where: 'id=?', whereArgs: [id]);
  getAllStudents();
}
