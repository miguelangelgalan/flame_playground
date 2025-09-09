import 'package:flame/game.dart';
import 'package:flame_playground/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

void main() {
  final game = FlameGame(world: MyWorld());
  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'PauseMenu': (context, game) {
          return Container(
            color: Colors.red,
            child: Center(child: Text('Pause Menu')),
            height: 100.0,
            width: 300.0,
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
  }
}
