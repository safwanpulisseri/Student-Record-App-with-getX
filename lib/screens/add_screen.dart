import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/controller/image_picker.dart';
import 'package:student_details_app/model/model_db.dart';

class ScreenAdd extends StatelessWidget {
  ScreenAdd({Key? key}) : super(key: key);

  final GlobalKey<FormState> _validation = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _mobileController = TextEditingController();

  final Imagecontroller imageController = Get.put(Imagecontroller());
  final HomeController homeController = Get.put(HomeController());

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
                        Obx(() {
                          return GestureDetector(
                            onTap: () {
                              pickimages(imageController);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 50,
                              backgroundImage: imageController
                                          .selectedImage.value !=
                                      null
                                  ? FileImage(File(imageController
                                      .selectedImage.value!.path))
                                  : const AssetImage('assets/images/hero.png')
                                      as ImageProvider,
                            ),
                          );
                        }),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Student Name';
                            }
                            return null;
                          },
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            suffixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an Age';
                            }
                            return null;
                          },
                          controller: _ageController,
                          decoration: const InputDecoration(
                            hintText: 'Age',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an Address';
                            }
                            return null;
                          },
                          controller: _addressController,
                          decoration: const InputDecoration(
                            hintText: 'Address',
                            suffixIcon: Icon(Icons.location_on),
                          ),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Phone Number';
                            } else if (value.length != 10) {
                              return 'Please enter a 10-digit Phone Number';
                            }
                            return null;
                          },
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            //prefixText: '+91 ',
                            hintText: 'Phone',
                            suffixIcon: Icon(Icons.phone),
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
                onSubmit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
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

  void onSubmit() {
    if (_validation.currentState!.validate() &&
        imageController.selectedImage.value != null) {
      Studentmodel value = Studentmodel()
        ..name = _nameController.text.trim()
        ..age = _ageController.text.trim()
        ..address = _addressController.text.trim()
        ..mobile = _mobileController.text.trim()
        ..image = imageController.selectedImage.value!.path;
      homeController.addStudentToDb(value);
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Please complete the form and select a photo',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.horizontal,
      );
    }
  }
}
