import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/screens/add_screen.dart';

final HomeController homeController = Get.put(HomeController());

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Student Record',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: StudentSearchDelegate(),
          //     );
          //   },
          //   icon: const Icon(
          //     Icons.search,
          //     color: Colors.white,
          //   ),
          // ),
        ],
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (homeController.students.isEmpty) {
            return const Center(
              child: Text(
                'No Result',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          }
          return GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: homeController.students.length,
            itemBuilder: (context, index) {
              final student = homeController.students[index];
              return GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ScreenDetails(studentdetails: data),
                  //   ),
                  // );
                },
                child: Card(
                  color: Colors.black45,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                        backgroundImage: student.image.isNotEmpty
                            ? FileImage(File(student.image))
                            : const AssetImage('assets/images/hero.png')
                                as ImageProvider,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Name: ${student.name}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Age: ${student.age}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          Get.to(
            () => ScreenAdd(),
            transition: Transition.cupertinoDialog,
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
