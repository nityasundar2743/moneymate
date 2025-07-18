import 'package:flutter/material.dart';
import 'package:moneymate/screens/dashboard/dashboard_screen.dart';

void main() => runApp(MoneyMateApp());

class MoneyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      home: DashboardScreen(),
    );
  }
}