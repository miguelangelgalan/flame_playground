import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_playground/main.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends Component
    with HasGameReference<MyGameWithSpriteAnimation>, TapCallbacks {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(
      TextComponent(
        text: 'GAME OVER',
        position: game.size / 2,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 64.0, color: Colors.red),
        ),
      ),
    );
  }

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onTapUp(TapUpEvent event) {
    //game.player.position = Vector2(100, 100);
    game.showingGameOverScreen = false;
    game.gameOver = false;
    //game.router.pop();
    game.router.pushNamed('gamerestart');
    super.onTapUp(event);
  }
}
