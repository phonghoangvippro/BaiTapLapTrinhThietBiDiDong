import 'package:flutter/material.dart';

class MissionView extends StatefulWidget {
  const MissionView({super.key});

  @override
  State<MissionView> createState() => _MissionViewState();
}

class _MissionViewState extends State<MissionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('List'),
      ),
    );
  }
}
