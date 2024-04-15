import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/screens/details_screen.dart';

class StudentSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.black,
        onPressed: () {
          query = '';
        },
        icon: const Icon(
          Icons.clear,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.black,
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Not used as we're showing results in the home screen itself
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Studentmodel> suggestionList = studentlistNotifier.value
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (suggestionList.isEmpty) {
      return const Center(
        child: Text(
          'No students found.',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final Studentmodel student = suggestionList[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: student.image.isNotEmpty
                ? FileImage(File(student.image))
                : const AssetImage('assets/images/hero.png') as ImageProvider,
          ),
          title: Text(student.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => ScreenDetails(
                  studentdetails: student,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
