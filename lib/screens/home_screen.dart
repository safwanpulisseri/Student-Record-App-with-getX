import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/screens/add_screen.dart';
import 'package:student_details_app/screens/details_screen.dart';
import 'package:student_details_app/widgets/search.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text(
          'Student Record',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: StudentSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
        leading: Container(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: studentlistNotifier,
          builder: (BuildContext ctx, List<Studentmodel> studentList,
              Widget? child) {
            if (studentList.isEmpty) {
              return const Center(
                child: Text(
                  'No student records found.',
                  style: TextStyle(fontSize: 20),
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
              itemCount: studentList.length,
              itemBuilder: (ctx, index) {
                final data = studentList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScreenDetails(studentdetails: data),
                      ),
                    );
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
                          backgroundImage: data.image.isNotEmpty
                              ? FileImage(File(data.image))
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
                              'Name: ${data.name}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Age: ${data.age}',
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
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScreenAdd()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
