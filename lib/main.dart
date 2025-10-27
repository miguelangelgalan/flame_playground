import 'dart:async';

import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flame_playground/Player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/components.dart';

void main() {
  //final game = FlameGame(world: MyWorld());
  //final game = MyGame();
  final gameWithAnimation = MyGameWithSpriteAnimation();
  final gameWithSpawn = MyGameWithSpriteAnimationAndSpawn();

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

/*
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
*/
// Lets play with SPrite Annimations
class MyGameWithSpriteAnimation extends FlameGame
    with SingleGameInstance, KeyboardEvents {
  //late final SpriteAnimationComponent player;
  late final Player player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    /* JOYSTICK */
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    player = Player(joystick);
    world.add(player);
    add(MyParallaxComponent());
    add(joystick);
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        player.position.x += 10;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        player.position.x -= 10;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        player.position.y -= 10;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        player.position.y += 10;
      }
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
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

class MyParallaxComponent extends ParallaxComponent<MyGameWithSpriteAnimation> {
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
      baseVelocity: Vector2(50, 00),
      velocityMultiplierDelta: Vector2(1.0, 1.0),
    );
  }
}
