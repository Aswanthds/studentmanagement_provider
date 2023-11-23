// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement_provider/controllers/controller.dart';
import 'package:studentmanagement_provider/model/db_model.dart';
import 'package:studentmanagement_provider/view/widgets/custom_dropdown.dart';
import 'package:studentmanagement_provider/view/widgets/custom_form_field.dart';
import 'package:studentmanagement_provider/view/widgets/custom_submit_button.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final formKey = GlobalKey<FormState>();
  Gender selectedGender = Gender.none;
  @override
  Widget build(BuildContext context) {
    return Consumer<ActionController>(
      builder: (context, value, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text("Add Student"),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 15,
                right: 10,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        controller: value.nameController,
                        current: value.nameFocus,
                        next: value.ageFocus,
                        hint: "Name",
                        type: TextInputType.text),
                    CustomAgeFormField(
                      controller: value.ageController,
                      current: value.ageFocus,
                      next: value.gradeFocus,
                      hint: "Age",
                      type: TextInputType.number,
                    ),
                    CustomFormField(
                      controller: value.gradeController,
                      current: value.gradeFocus,
                      next: null,
                      hint: "Class & Division",
                      type: TextInputType.text,
                    ),
                    CustomDropDownButton(selectedGender: selectedGender),
                    SizedBox(
                      height: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OutlinedButton.icon(
                              onPressed: () {
                                value.pickImage();
                              },
                              icon: const Icon(Icons.upload_outlined),
                              label: const Text("Add Photo")),
                          Center(
                            child: value.selectedImage != null
                                ? Image.file(
                                    value.selectedImage!,
                                    height: 150,
                                    width: 150,
                                  )
                                : const Text('No image selected'),
                          ),
                          IconButton(
                              onPressed: () {
                                value.clearSelectedImage();
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: CustomSubmitButton(
                  controller: value,
                  selectedGender: selectedGender.name,
                  formKey: formKey),
            ),
          ],
        ),
      ),
    );
  }
}
