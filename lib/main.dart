import 'package:flutter/material.dart';
import 'package:nomadcoder_webtoon_challenge/screens/home_screen.dart';

void main() {
  runApp(const WebtoonApp());
}

class WebtoonApp extends StatelessWidget {
  const WebtoonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
