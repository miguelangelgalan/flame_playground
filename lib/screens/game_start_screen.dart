import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flame_playground/main.dart';
import 'package:flutter/material.dart';

class GameStartScreen extends Component
    with HasGameReference<MyGameWithSpriteAnimation>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      TextComponent(
        text: 'START',
        position: game.size / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 64.0, color: Colors.green),
        ),
      ),
    );
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    game.router.pushNamed('gameplay');
    super.onTapUp(event);
  }
}
