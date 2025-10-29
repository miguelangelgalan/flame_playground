import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_playground/Player.dart';
import 'package:flame_playground/main.dart';

class Monster extends SpriteComponent
    with HasGameReference<MyGameWithSpriteAnimation>, CollisionCallbacks {
  Monster({Vector2? position, Vector2? size, Anchor anchor = Anchor.center})
    : super(position: position, size: size ?? Vector2.all(100), anchor: anchor);

  @override
  Future<void> onLoad() async {
    // Load the sprite image
    sprite = await game.loadSprite('38.png');
    //add(RectangleHitbox(size: size / 2));
    add(
      CircleHitbox(
        radius: size.x / 4,
        position: Vector2(size.x / 4, size.y / 4),
      ),
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    //print("PRE-COLISION" + other.toString());
    if (other is Player) {
      print("COLISION" + other.toString());
      removeFromParent();
      //remove(this);
      //game.remove(other);
    }
  }
}
