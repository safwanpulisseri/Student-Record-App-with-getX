import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Imagecontroller extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
}

pickimages(Imagecontroller imagecontroller) async {
  Get.defaultDialog(
      title: 'Select Photo',
      titleStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      content: const Text(
        'Please choose any option to add profile',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: Colors.green.shade900,
      actions: [
        ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.white)),
            onPressed: () async {
              Get.back();
              final pickedimage =
                  await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedimage != null) {
                imagecontroller.selectedImage.value = File(pickedimage.path);
              }
            },
            child: const Text(
              'Camera',
              style: TextStyle(color: Colors.black),
            )),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white)),
          onPressed: () async {
            Get.back();
            final pickedimage =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (pickedimage != null) {
              imagecontroller.selectedImage.value = File(pickedimage.path);
            }
          },
          child: const Text(
            'Gallery',
            style: TextStyle(color: Colors.black),
          ),
        )
      ]);
}
