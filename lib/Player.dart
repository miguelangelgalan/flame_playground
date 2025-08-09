import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Player extends SpriteComponent with TapCallbacks {
  Player({super.position})
    : super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('Player.png');
  }

  @override
  void onTapUp(TapUpEvent info) {
    size += Vector2.all(50);
  }
}
