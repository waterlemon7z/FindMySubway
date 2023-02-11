import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("main"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Text("1"),
    );
  }
}
