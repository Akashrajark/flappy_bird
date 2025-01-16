import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/components/pipe_manager.dart';
import 'package:flappy_bird/components/score.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    ground = Ground();
    add(ground);

    bird = Bird();
    add(bird);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTap() {
    bird.flap();
    if (isGameOver) {
      restartGame();
    }
  }

  int score = 0;

  void incrmentScore() {
    score += 1;
  }

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) {
      return;
    }

    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Score $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              restartGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void restartGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    isGameOver = false;
    score = 0;
    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
