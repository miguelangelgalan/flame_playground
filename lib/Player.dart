import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class Player extends SpriteComponent with TapCallbacks, HasGameRef<FlameGame> {
  Player({super.position})
    : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Player.png');
  }

  @override
  void onTapUp(TapUpEvent info) {
    size += Vector2.all(50);
    // Show the pause menu overlay using Flame's overlay system
    gameRef.overlays.add('PauseMenu');
  }
}
