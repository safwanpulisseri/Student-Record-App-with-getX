import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/widgets/snackbar.dart';

String? image;

class ScreenAdd extends StatefulWidget {
  const ScreenAdd({super.key});

  @override
  State<ScreenAdd> createState() => _ScreenAddState();
}

class _ScreenAddState extends State<ScreenAdd> {
  final GlobalKey<FormState> _validation = GlobalKey<FormState>();

  final _namecontroller = TextEditingController();
  final _agecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _mobilecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          'Add',
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
              child: Form(
                key: _validation,
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
                                    'Select image from...',
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            getImage(
                                                ImageSource.camera, context);
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Student Name';
                            }
                            return null;
                          },
                          controller: _namecontroller,
                          decoration: const InputDecoration(
                              hintText: 'Name',
                              suffixIcon: Icon(
                                Icons.abc,
                              )),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Class';
                            }
                            return null;
                          },
                          controller: _agecontroller,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.class_,
                            ),
                            hintText: 'Age',
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Guardian Name';
                            }
                            return null;
                          },
                          controller: _addresscontroller,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.person_2_rounded,
                            ),
                            hintText: 'Address',
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Phone Number';
                            } else if (value.length != 10) {
                              return 'Please enter ten digits Phone Number';
                            }
                            return null;
                          },
                          controller: _mobilecontroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.phone,
                            ),
                            hintText: 'Phone',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addStudentClicked(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text(
                'Add',
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

  Future<void> addStudentClicked(BuildContext context) async {
    final name = _namecontroller.text.trim();
    final age = _agecontroller.text.trim();
    final address = _addresscontroller.text.trim();
    final mobile = _mobilecontroller.text.trim();

    if (_validation.currentState!.validate() && image != null) {
      final student = Studentmodel(
          name: name,
          age: age,
          address: address,
          mobile: mobile,
          image: image!);
      await addStudent(student);

      Navigator.of(context).pop();
      clearStudentProfilephoto();
      submitbuttondetailsok(name);
    } else if (_validation.currentState!.validate() && image == null) {
      submitbuttondetailnotok();
    }
  }

  clearStudentProfilephoto() {
    _namecontroller.text = '';
    _agecontroller.text = '';
    _addresscontroller.text = '';
    _mobilecontroller.text = '';
    setState(() {
      image = null;
    });
  }

  submitbuttondetailsok(data) {
    snackbar('$data\'s Details Added', context);
  }

  submitbuttondetailnotok() {
    snackbar('Please Add Student Identity Photo', context);
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
