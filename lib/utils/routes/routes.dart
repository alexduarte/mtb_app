import 'package:flutter/material.dart';
import 'package:mtb_app/pages/home_page.dart';
import 'package:mtb_app/pages/login_page.dart';

final routes = {
  '/login': (BuildContext context) => new LoginPage(),
  '/home': (BuildContext context) => new HomePage(),
  '/': (BuildContext context) => new LoginPage()
}; 