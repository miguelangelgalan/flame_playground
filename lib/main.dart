import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame_playground/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

void main() {
  //final game = FlameGame(world: MyWorld());
  final game = MyGame();
  final gameWithAnimation = MyGameWithSpriteAnimation();
  ;

  runApp(
    GameWidget(
      game: gameWithAnimation,
      overlayBuilderMap: {
        'PauseMenu': (context, game) {
          return Center(
            child: Container(
              color: Colors.red,
              height: 100.0,
              width: 300.0,
              child: Text('Pause Menu'),
            ),
          );
        },
      },
      //initialActiveOverlays: ['PauseMenu'],
    ),
  );
}

class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    add(Player(position: Vector2(0, 0)));
    add(Player(position: Vector2(100, 100)));
  }
}

class MyGame extends FlameGame with SingleGameInstance {
  MyGame() : super(world: MyWorld());
  @override
  Color backgroundColor() => Colors.blue;
}

// Lets play with SPrite Annimations
class MyGameWithSpriteAnimation extends FlameGame with SingleGameInstance {
  late final SpriteAnimationComponent player;

  @override
  Future<void> onLoad() async {
    final size = Vector2.all(128);
    final data = SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.1,
      textureSize: size,
    );
    this.player = SpriteAnimationComponent.fromFrameData(
      await images.load("Run.png"),
      data,
    );
    this.world.add(this.player);
  }
}
