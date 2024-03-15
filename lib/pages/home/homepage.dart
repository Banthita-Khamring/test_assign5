
import 'package:flutter/material.dart';
import 'package:test_assign5/pages/home/widgets/showbeer.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BEER',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              
        ),
      ),
      body: Mywidget(),
    );
  }
}
