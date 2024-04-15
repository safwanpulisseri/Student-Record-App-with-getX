import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/screens/home_screen.dart';
import 'package:student_details_app/widgets/snackbar.dart';

class ScreenUpdate extends StatefulWidget {
  final Studentmodel studentDetails;

  const ScreenUpdate({super.key, required this.studentDetails});

  @override
  State<ScreenUpdate> createState() => _ScreenUpdateState();
}

class _ScreenUpdateState extends State<ScreenUpdate> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _addressController;
  late TextEditingController _mobileController;
  late String? image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentDetails.name);
    _ageController = TextEditingController(text: widget.studentDetails.age);
    _addressController =
        TextEditingController(text: widget.studentDetails.address);
    _mobileController =
        TextEditingController(text: widget.studentDetails.mobile);
    image = widget.studentDetails.image;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Update',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Select Option',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          getImage(ImageSource.camera, context);
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt_rounded,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          getImage(
                                              ImageSource.gallery, context);
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.image,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 50,
                          backgroundImage: image != null
                              ? FileImage(File(image!))
                              : const AssetImage('assets/images/hero.png')
                                  as ImageProvider,
                        ),
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            hintText: 'Name',
                            suffixIcon: Icon(
                              Icons.abc,
                            )),
                      ),
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.class_,
                          ),
                          hintText: 'Age',
                        ),
                      ),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.person_2_rounded,
                          ),
                          hintText: 'Address',
                        ),
                      ),
                      TextFormField(
                        controller: _mobileController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.phone,
                          ),
                          hintText: 'Mobile',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateStudent(
                  widget.studentDetails.id!,
                  _nameController.text,
                  _ageController.text,
                  _addressController.text,
                  _mobileController.text,
                  image ??
                      widget.studentDetails
                          .image, // Use the new image if available, otherwise use the existing image
                );
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const ScreenHome()));
                snackbar('Successfully Updated', context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getImage(ImageSource source, BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage.path;
      });
    }
  }
}
