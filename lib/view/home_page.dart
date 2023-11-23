import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement_provider/controllers/controller.dart';
import 'package:studentmanagement_provider/model/db_model.dart';
import 'package:studentmanagement_provider/view/add_student.dart';
import 'package:studentmanagement_provider/view/edit_student.dart';
import 'package:studentmanagement_provider/view/search_page.dart';
import 'package:studentmanagement_provider/view/student_whole.dart';
import 'package:studentmanagement_provider/view/widgets/constants.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ActionController>(builder: (context, value, _) {
      List<Student> students = value.getStudents();
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Student Management",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
                  value.initializeStudents();
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: ListView.builder(
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            //debugPrint(student.imgPath);

            return ListTile(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileWidget(index: index),
              )),
              leading: student.imgPath != null
                  ? SizedBox.square(
                      dimension: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: FileImage(File(student.imgPath!)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : const CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
              title: Text(
                student.name,
                style: const TextStyle(fontSize: 20),
              ),
              subtitle: Text('Age: ${student.age}'),
              trailing: Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditStudentPage(
                              studentName: student.name, controller: value),
                        ));
                        // controller.updateStudent(
                        //     id: student.id,
                        //     newAge: '11',
                        //     newName: 'POLIC555E');
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Are you Sure"),
                            content:
                                const Text("Once deleted never retreve it"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton.icon(
                                onPressed: () {
                                  value.deleteStudent(index);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(deleteStudentSnack());
                                  Navigator.pop(context);
                                },
                                label: const Text("Delete"),
                                icon: const Icon(Icons.delete_outline),
                              )
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
              // Add other details here if needed
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(
              side: BorderSide(color: Colors.lightBlueAccent)),
          backgroundColor: Colors.lightBlueAccent,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddStudent(),
            ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
/*

                */