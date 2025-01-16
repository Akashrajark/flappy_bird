import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird/components/pipe.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  double pipeSpawnTimer = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;

    const double pipeIntervel = 2;

    if (pipeSpawnTimer > pipeIntervel) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    final double screenHeight = gameRef.size.y;

    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    final bottomPipe = Pipe(
      position: Vector2(
          gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      size: Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );

    final topPipe = Pipe(
      position: Vector2(gameRef.size.x, 0),
      size: Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }
}
