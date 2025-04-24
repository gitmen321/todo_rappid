// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rappid/viewmodels/task_view_model.dart';
import 'package:todo_rappid/views/login_screen.dart';
import 'package:todo_rappid/views/widgets/custom_loader.dart';
import 'package:todo_rappid/views/widgets/task_input_fie;d.dart';
import '../models/task.dart';
import 'widgets/task_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Logout function
  void _logout(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);
    viewModel.setUserId(''); // Clear the userId
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context);
    final username = viewModel.userId; // Get the username (userId)

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 9, 11), // Dark background
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 10, 51, 79),
        elevation: 0,
        title: Text(
          'TODO App',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 18, 25, 32),
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      username.isNotEmpty ? username : 'Guest',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.logout, color: Colors.redAccent),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => _logout(context),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color.fromARGB(255, 18, 25, 32), Color.fromARGB(255, 10, 51, 79)],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth > 600;
            return Column(
              children: [
                SizedBox(height: isTablet ? 20 : 10),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(60)),
                    child: Container(
                      color: Colors.white.withOpacity(0.95),
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(isTablet ? 20.0 : 10.0),
                            child: TaskInputField(),
                          ),
                          Expanded(
                            child: StreamBuilder<List<Task>>(
                              stream: viewModel.tasks,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                }
                                if (!snapshot.hasData) {
                                  return Center(child: CustomLoader());
                                }
                                final tasks = snapshot.data!;
                                return AnimatedList(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 20.0 : 10.0,
                                    vertical: 10.0,
                                  ),
                                  initialItemCount: tasks.length,
                                  itemBuilder: (context, index, animation) {
                                    return SizeTransition(
                                      sizeFactor: animation,
                                      child: TaskListItem(task: tasks[index]),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}