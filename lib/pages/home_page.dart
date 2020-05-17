import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("Inicial")),
      body: new Center(
        child: new Center(
          child: new Text("Bem vindo")
        ),
      ),
    );
  }
}