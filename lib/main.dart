import 'package:flutter/material.dart';
import 'package:mtb_app/utils/routes/routes.dart' ;

void main() => runApp(MtbApp());

class MtbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      routes: routes,
    );
  }
}