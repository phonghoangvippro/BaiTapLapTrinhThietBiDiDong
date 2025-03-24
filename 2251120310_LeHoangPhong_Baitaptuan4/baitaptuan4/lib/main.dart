import 'package:baitap2_tuan3/tabbar/tabbar.dart';
import 'package:flutter/material.dart';

import 'splash/splash.dart' show SplashScreen;

void main(List<String> args) {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Tabbar(),
  ));
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
