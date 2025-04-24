import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Color(0xFF2C3E50),
    );
  }
}