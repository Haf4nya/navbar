import 'package:flutter/material.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(100),
                margin: EdgeInsets.all(100),
                decoration: BoxDecoration(color: Colors.grey[00]),
              )
            ],
          )
        ],
      ),
    );
  }
}
