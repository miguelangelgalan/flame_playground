import 'package:flame/game.dart';
import 'package:flame_playground/Player.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';

void main() {
  final game = FlameGame(world: MyWorld());
  runApp(GameWidget(game: game));
}

class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    add(Player(position: Vector2(0, 0)));
  }
}
