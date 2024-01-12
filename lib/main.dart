import 'package:flutter/material.dart';

import 'package:good_mind/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}


//https://i.pinimg.com/564x/bf/9a/fe/bf9afe6e8fa53912e7d407310c91be68.jpg