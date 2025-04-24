import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_rappid/viewmodels/task_view_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _isPasswordVisible = false; // State to toggle password visibility

  // Hardcoded users
  final Map<String, Map<String, String>> _users = {
    'user1@gmail.com': {'password': 'pass123', 'userId': 'user1'},
    'user2@gmail.com': {'password': 'pass123', 'userId': 'user2'},
  };

  void _signIn() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('Attempting login with email: $email');

    // Check if the email exists and the password matches
    if (_users.containsKey(email) && _users[email]!['password'] == password) {
      final userId = _users[email]!['userId']!;
      print('User logged in: $userId, $email');
      
      // Update the TaskViewModel with the logged-in userId
      Provider.of<TaskViewModel>(context, listen: false).setUserId(userId);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Login Error: Invalid credentials for email: $email');
      setState(() {
        _errorMessage = 'Invalid email or password';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _errorMessage,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  // Toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFF1E3C72), Color.fromARGB(255, 10, 22, 41)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, size: 60, color: Color(0xFF2A5298)),
                    SizedBox(height: 20),
                    Text(
                      'Welcome Back',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3C72),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xFF2A5298),
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      obscureText: !_isPasswordVisible, // Toggle visibility
                    ),
                    SizedBox(height: 15),
                    if (_errorMessage.isNotEmpty)
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        backgroundColor: Color(0xFF2A5298),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        // Add sign-up navigation or logic here if needed
                      },
                      child: Text('Create Account', style: TextStyle(color: Color(0xFF2A5298))),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}