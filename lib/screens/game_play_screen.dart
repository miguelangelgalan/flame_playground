import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame_playground/Explosion.dart';
import 'package:flame_playground/Monster.dart';
import 'package:flame_playground/Player.dart';
import 'package:flame_playground/main.dart';
import 'package:flutter/material.dart';

// Lets play with SPrite Annimations
class GamePlayScreen extends Component
    with
        HasGameReference<MyGameWithSpriteAnimation>,
        /*KeyboardEvents,*/
        HasCollisionDetection {
  //late final SpriteAnimationComponent player;
  late final Player player;
  late final JoystickComponent joystick;
  late final Explosion explosion;

  @override
  Future<void> onLoad() async {
    explosion = Explosion(position: Vector2(0, 0));
    /* JOYSTICK */
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 30, paint: knobPaint),
      background: CircleComponent(radius: 100, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );

    /* PLAYER */
    player = Player(joystick);
    add(player);

    /* PARALLAX */
    game.add(MyParallaxComponent());

    /* Add explosion sprite */
    //world.add(explosion);

    /* MONSTERS */
    final random = Random();
    final monsters = List.generate(10, (index) {
      return Monster(
        position: Vector2(
          random.nextDouble() * game.size.x,
          random.nextDouble() * game.size.y,
        ),
        size: Vector2(80, 80),
        explosion: explosion,
        isKiller: index % 5 == 0,
      );
    });

    for (final monster in monsters) {
      //print(monster.toString());
      add(monster);
    }

    game.add(joystick);
    //debugMode = true;
  }

  /*@override
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
  }*/
}
