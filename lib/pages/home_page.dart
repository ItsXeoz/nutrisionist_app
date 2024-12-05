import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Home Page'),
      ),
      body: ElevatedButton(
        style: ButtonStyle(),
        onPressed: () {},
        child: Text('Logout'),
      ),
    );
  }
}
