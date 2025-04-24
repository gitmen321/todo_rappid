// ignore: file_names
import 'package:flutter/material.dart';
import 'package:todo_rappid/viewmodels/task_view_model.dart';
import 'package:provider/provider.dart';

class TaskInputField extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TaskInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 20.0 : 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Task Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 23, 40, 54)),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  style: TextStyle(fontSize: isTablet ? 18 : 16),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: const Color.fromARGB(255, 22, 43, 59)),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  style: TextStyle(fontSize: isTablet ? 16 : 14),
                  maxLines: 3,
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                      viewModel.addTask(
                        _titleController.text,
                        _descriptionController.text,
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12), backgroundColor: Color(0xFF2C3E50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    'Add Task',
                    style: TextStyle(fontSize: isTablet ? 18 : 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}