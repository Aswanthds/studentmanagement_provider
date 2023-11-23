import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement_provider/controllers/controller.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ActionController>(builder: (context, controller, _) {
      final searchResults = controller.searchResults;

      controller.initializeStudents();
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    controller.searchByName(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search by name...',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    final student = searchResults[index];
                    return ListTile(
                      title: Text(student.name),
                      subtitle: Text('Age: ${student.age}'),
                      // Add more student information as needed
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
