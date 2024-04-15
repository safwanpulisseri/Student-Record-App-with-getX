import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_details_app/controller/controller.dart';
import 'package:student_details_app/controller/image_picker.dart';
import 'package:student_details_app/model/model_db.dart';
import 'package:student_details_app/screens/home_screen.dart';

class ScreenUpdate extends StatelessWidget {
  final Studentmodel studentDetails;
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Imagecontroller imagecontroller = Get.put(Imagecontroller());

  ScreenUpdate({Key? key, required this.studentDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: studentDetails.name);
    TextEditingController ageController =
        TextEditingController(text: studentDetails.age);
    TextEditingController addressController =
        TextEditingController(text: studentDetails.address);
    TextEditingController mobileController =
        TextEditingController(text: studentDetails.mobile);

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
                      Obx(() {
                        return GestureDetector(
                          onTap: () {
                            pickimages(
                                imagecontroller); // Corrected method name
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 50,
                            backgroundImage: imagecontroller
                                        .selectedImage.value !=
                                    null
                                ? FileImage(File(
                                    imagecontroller.selectedImage.value!.path))
                                : const AssetImage('assets/images/hero.png')
                                    as ImageProvider,
                          ),
                        );
                      }),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'Name',
                            suffixIcon: Icon(
                              Icons.abc,
                            )),
                      ),
                      TextFormField(
                        controller: ageController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.class_,
                          ),
                          hintText: 'Age',
                        ),
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.person_2_rounded,
                          ),
                          hintText: 'Address',
                        ),
                      ),
                      TextFormField(
                        controller: mobileController,
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
              onPressed: () async {
                checkImage(imagecontroller, studentDetails);
                homeController.updateStudent(
                    studentDetails,
                    nameController.text,
                    ageController.text,
                    addressController.text,
                    mobileController.text,
                    imagecontroller);
                Get.offAll(const ScreenHome());
                Get.snackbar('Success', 'Student details updated Successfully',
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 2),
                    dismissDirection: DismissDirection.horizontal);
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

  void checkImage(Imagecontroller ic, Studentmodel std) {
    ic.selectedImage.value ??= File(std.image);
  }
}
