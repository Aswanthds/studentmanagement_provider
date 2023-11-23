import 'dart:io';
// ignore: unused_import

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentmanagement_provider/model/db_model.dart';

class ActionController extends ChangeNotifier {
  final selected = "None";
  final Box<Student> _studentBox = Hive.box<Student>('students');
  final _picker = ImagePicker();

  File? _selectedImage;

  File? get selectedImage => _selectedImage;
  List<String> list = ['Male', 'Female', 'None'];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode gradeFocus = FocusNode();

  Gender getGenderFromString(String genderString) {
    for (var gender in Gender.values) {
      if (gender.toString().toLowerCase() == genderString.toLowerCase()) {
        return gender;
      }
    }
    // If no match is found, you can return a default value or throw an error
    return Gender.none; // Default value, change as needed
  }




  List<Student> getStudents() {
    return _studentBox.values.toList();
  }

  void addStudent(Student student) {
    try {
      _studentBox.add(student);
      notifyListeners();
      debugPrint("To Do Object added ${student.name}");
    } catch (e) {
      debugPrint("Erro occured while adding $e");
    }
  }

  void deleteStudent(int index) {
    _studentBox.deleteAt(index);
    notifyListeners(); // Trigger an update to reflect changes in the UI
  }

  void updateStudent(
      {String? id,
      String? newName,
      String? newAge,
      String? newGender,
      String? newGrade,
      String? newImg}) {
    final List<Student> students = getStudents();
    final studentIndex = students.indexWhere((student) => student.id == id);
    if (studentIndex != -1) {
      students[studentIndex].name = newName ?? students[studentIndex].name;
      students[studentIndex].age = newAge ?? students[studentIndex].age;
      students[studentIndex].grade = newGrade ?? students[studentIndex].age;
      students[studentIndex].imgPath = newImg ?? students[studentIndex].imgPath;
      // Update other fields as needed
      notifyListeners(); // Trigger a refresh in the UI
    }
  }

  Student? getStudentByName(String name) {
    final List<Student> students = getStudents();
    return students.firstWhere(
      (student) => student.name.toLowerCase() == name.toLowerCase(),
      orElse: () => Student(
          gender: Gender.other.name, age: '', grade: '', id: '', name: name),
    );
  }

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _selectedImage = File(pickedImage.path);
      notifyListeners(); // Notify listeners about the change in selectedImage
    }
  }

  void clearSelectedImage() {
    _selectedImage = null;
    notifyListeners(); // Notify listeners about the change (image cleared)
  }

   List<Student> _students = [];
  List<Student> _searchResults = [];

  void initializeStudents() {
    _students = getStudents();
    _searchResults = List.from(_students);
  }

  List<Student> get searchResults => _searchResults;

  void searchByName(String query) {
    _searchResults = _students
        .where((student) =>
            student.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
