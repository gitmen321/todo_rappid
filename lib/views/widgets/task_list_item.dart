// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rappid/viewmodels/task_view_model.dart';
import '../../models/task.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  // ignore: library_private_types_in_public_api
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _isHovered = false;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _shareUserIdController = TextEditingController(); // Changed to userId

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _shareUserIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: EdgeInsets.symmetric(
            horizontal: isTablet ? 16.0 : 8.0,
            vertical: 4.0,
          ),
          child: InkWell(
            onHover: (hovering) {
              setState(() {
                _isHovered = hovering;
              });
            },
            child: ListTile(
              contentPadding: EdgeInsets.all(isTablet ? 16.0 : 8.0),
              title: Text(
                widget.task.title,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                widget.task.description,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.black54,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: const Color.fromARGB(255, 25, 84, 26)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.white.withOpacity(0.95),
                          title: Text(
                            'Edit Task',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          content: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFEAF2F8),
                                  Color.fromARGB(255, 165, 218, 255)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextField(
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                    labelText: 'Title',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF2C3E50)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: const Color.fromARGB(255, 15, 34, 50)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style:
                                      TextStyle(fontSize: isTablet ? 18 : 16),
                                ),
                                SizedBox(height: 15),
                                TextField(
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle:
                                        TextStyle(color: Color(0xFF2C3E50)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: Colors.blueGrey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          BorderSide(color: const Color.fromARGB(255, 23, 50, 71)),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                  style:
                                      TextStyle(fontSize: isTablet ? 16 : 14),
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                viewModel.updateTask(
                                  widget.task,
                                  _titleController.text,
                                  _descriptionController.text,
                                );
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2C3E50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Done',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: const Color.fromARGB(255, 20, 69, 109)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Share Task'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Enter the user ID to share with (user1 or user2):'),
                              SizedBox(height: 10),
                              TextField(
                                controller: _shareUserIdController,
                                decoration: InputDecoration(
                                  labelText: 'User ID',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final userId = _shareUserIdController.text;
                                if (userId.isNotEmpty) {
                                  viewModel.shareTask(widget.task, userId);
                                }
                                Navigator.pop(context);
                              },
                              child: Text('Share'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              tileColor: _isHovered ? Colors.grey[200] : null,
            ),
          ),
        );
      },
    );
  }
}