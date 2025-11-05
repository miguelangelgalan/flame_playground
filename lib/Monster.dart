import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_playground/Explosion.dart';
import 'package:flame_playground/Player.dart';
import 'package:flame_playground/main.dart';

class Monster extends SpriteComponent
    with HasGameReference<MyGameWithSpriteAnimation>, CollisionCallbacks {
  Monster({
    Vector2? position,
    Vector2? size,
    required Explosion this.explosion,
    Anchor anchor = Anchor.center,
  }) : super(
         position: position,
         size: size ?? Vector2.all(100),
         anchor: anchor,
       );

  final Vector2 velocity = Vector2.all(100);
  final Explosion explosion;

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
  void update(double dt) {
    final screenSize = game.size;
    final nextX = position.x + velocity.x * dt;
    final nextY = position.y + velocity.y * dt;
    // Check boundaries
    if (nextX < -(screenSize.x / 2) || nextX > screenSize.x / 2) {
      velocity.x = -velocity.x;
    }
    if (nextY < -(screenSize.y / 2) || nextY > screenSize.y / 2) {
      velocity.y = -velocity.y;
    }
    position = Vector2(nextX, nextY);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    //print("PRE-COLISION" + other.toString());
    if (other is Player) {
      //print("COLISION" + other.toString());
      explosion.position = position;
      game.world.add(explosion);
      removeFromParent();
      //remove(this);
      //game.remove(other);
    }
  }
}
