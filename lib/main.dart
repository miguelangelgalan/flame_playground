import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame_playground/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

void main() {
  //final game = FlameGame(world: MyWorld());
  final game = MyGame();
  final gameWithAnimation = MyGameWithSpriteAnimation();
  final gameWithSpawn = MyGameWithSpriteAnimationAndSpawn();

  runApp(
    GameWidget(
      game: gameWithSpawn,
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
      await images.load("Attack_1.png"),
      data,
    );
    this.world.add(this.player);
  }
}

class MyGameWithSpriteAnimationAndSpawn extends FlameGame
    with SingleGameInstance {
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
      await images.load("Attack_1.png"),
      data,
    );
    SpawnComponent campoDeJuego = SpawnComponent(
      factory: (i) => player,
      period: 0.1,
      area: Circle(Vector2(100, 150), 300),
    );
    this.world.add(campoDeJuego);
    add(MyParallaxComponent());
  }
}

class MyParallaxComponent
    extends ParallaxComponent<MyGameWithSpriteAnimationAndSpawn> {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData('bg/1.png'),
        ParallaxImageData('bg/2.png'),
        ParallaxImageData('bg/3.png'),
        ParallaxImageData('bg/4.png'),
        ParallaxImageData('bg/5.png'),
        ParallaxImageData('bg/6.png'),
        ParallaxImageData('bg/7.png'),
      ],
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.1, 1.0),
    );
  }
}
