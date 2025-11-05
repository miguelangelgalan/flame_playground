import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_playground/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<MyGameWithSpriteAnimation> {
  Player(this.joystick) : super(size: Vector2.all(200), anchor: Anchor.center);

  double maxSpeed = 300.0;
  final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    final size = Vector2.all(128);
    final data = SpriteAnimationData.sequenced(
      amount: 8,
      stepTime: 0.1,
      textureSize: size,
    );

    // Load the sprite sheet image
    final image = await game.images.load("Attack_1.png");

    // Create the animation directly from the image and data
    animation = SpriteAnimation.fromFrameData(image, data);

    // Set the initial position
    //position = Vector2(100, 150);
    position = Vector2(0, 0);

    // Para colisiones
    //add(CircleHitbox(position: position / 2, radius: size.x / 2));
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.9),
        parentSize: size,
        position: Vector2(60, 80),
      ),
    );
  }

  @override
  void update(double dt) {
    if (joystick.direction != JoystickDirection.idle) {
      position.add(joystick.relativeDelta * maxSpeed * dt);
      angle = joystick.delta.screenAngle();
    }
  }
}
