import 'package:flame/game.dart';
import 'package:flappy_bird/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameWidget(
        game: FlappyBirdGame(),
      ),
    );
  }
}
