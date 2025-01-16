import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';
import 'package:flappy_bird/game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool isScored = false;

  Pipe({
    required Vector2 position,
    required Vector2 size,
    required this.isTopPipe,
  }) : super(position: position, size: size);

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe_top.png' : 'pipe_bottom.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundMovingSpeed * dt;

    if (!isScored && position.x + size.x < gameRef.bird.position.x) {
      isScored = true;
      if (isTopPipe) {
        gameRef.incrmentScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
