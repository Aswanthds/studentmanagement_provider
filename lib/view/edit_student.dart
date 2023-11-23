// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:studentmanagement_provider/controllers/controller.dart';
import 'package:studentmanagement_provider/model/db_model.dart';
import 'package:studentmanagement_provider/view/widgets/custom_form_field.dart';

class EditStudentPage extends StatelessWidget {
  final String studentName;
  EditStudentPage({
    super.key,
    required this.studentName,
    required this.controller,
  });

  final ActionController controller;

  String? selectedGender;
  File? selectedImage;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Student? studentData = controller.getStudentByName(studentName);

    if (studentData != null) {
      controller.nameController.text = studentData.name;
      controller.ageController.text = studentData.age;
      controller.gradeController.text = studentData.grade;
      selectedGender = studentData.gender ?? 'none';
      selectedImage = File(studentData.imgPath ?? '');
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Edit Student"),
      ),
      body: Column(
        children: [
          CustomFormField(controller: controller.nameController),
          CustomAgeFormField(
            controller: controller.ageController,
            hint: 'Age',
            type: TextInputType.number,
          ),
          CustomFormField(controller: controller.gradeController),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              bottom: 5.0,
            ),
            child: DropdownButtonFormField<Gender>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
              ),
              hint: const Text("Choose your gender",
                  style: TextStyle(color: Colors.black)),
              value: controller.getGenderFromString(selectedGender!),
              onChanged: (Gender? newValue) {
                if (newValue != null) {
                  selectedGender = newValue.name;
                }
              },
              items: Gender.values.map((Gender gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(
                    gender.toString().toUpperCase().split('.').last,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                  onPressed: () {
                    controller.pickImage();
                  },
                  icon: const Icon(Icons.upload_outlined),
                  label: const Text("Add Photo")),
              (controller.selectedImage != null)
                  ? Image.file(
                      controller.selectedImage!,
                      height: 150,
                    )
                  : Image.file(
                      File(
                        studentData?.imgPath ?? '',
                      ),
                      height: 150,
                    ),
              IconButton(
                  onPressed: () {
                    controller.clearSelectedImage();
                    debugPrint(studentData?.imgPath.toString());
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              final String name = controller.nameController.text;
              final age = controller.ageController.text;
              final grade = controller.gradeController.text;
              final image = controller.selectedImage?.path;
              if (name.isNotEmpty && age.isNotEmpty && grade.isNotEmpty) {
                controller.updateStudent(
                  id: studentData?.id,
                  newAge: age,
                  newName: name,
                  newGrade: grade,
                  newGender: selectedGender,
                  newImg: image ?? studentData?.imgPath,
                );
                controller.nameController.clear();
                controller.ageController.clear();
                controller.gradeController.clear();
                controller.clearSelectedImage();
                Navigator.of(context).pop();

                // controller.editedStudentSnack();
              }
            },
            child: const SizedBox(
                width: double.maxFinite,
                height: 30,
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ))),
          ),
        ],
      ),
    );
  }
}
