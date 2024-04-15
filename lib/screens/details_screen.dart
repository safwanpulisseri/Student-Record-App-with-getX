import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/screens/home_screen.dart';
import 'package:student_details_app/widgets/snackbar.dart';

class ScreenDetails extends StatelessWidget {
  final Studentmodel studentdetails;

  const ScreenDetails({super.key, required this.studentdetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text(
          "Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      onDelete(studentdetails);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.grey.shade600,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ScreenUpdate(studentDetails: studentdetails),
                      //   ),
                      // );
                    },
                    icon: Icon(
                      Icons.edit_square,
                      color: Colors.grey.shade600,
                      size: 40,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 220,
                        width: 220,
                        child: studentdetails.image.isNotEmpty
                            ? Image.file(
                                File(studentdetails.image),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                'assets/images/hero.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text(
                    'Name: ${studentdetails.name}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text(
                    'Age: ${studentdetails.age}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text(
                    'Adress: ${studentdetails.address}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Text(
                    'Phone: ${studentdetails.mobile}',
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void onDelete(Studentmodel student) {
  Get.defaultDialog(
    title: 'Confirm Deletion',
    content: const Text('Are you sure you want to delete?'),
    backgroundColor: Colors.white,
    radius: 10,
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: const Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
      ),
      TextButton(
        onPressed: () {
          Get.find<HomeController>().delete(student);
          Get.back();
          Get.off(() => const ScreenHome());
          Get.snackbar(
            'Deleted',
            'Student details removed',
            backgroundColor: Colors.red,
            overlayBlur: 1,
            duration: const Duration(seconds: 2),
          );
        },
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.red),
        ),
      ),
    ],
  );
}
