import 'package:flame/components.dart';
import 'package:flame_playground/main.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<MyGameWithSpriteAnimation> {
  Explosion({Vector2? position, Vector2? size})
    : super(
        position: position ?? Vector2.zero(),
        size: size ?? Vector2.all(100),
        anchor: Anchor.center,
      );

  @override
  Future<void> onLoad() async {
    // Load all explosion images
    final images = [
      await game.images.load("explosion/Explosion_1.png"),
      await game.images.load("explosion/Explosion_2.png"),
      await game.images.load("explosion/Explosion_3.png"),
      await game.images.load("explosion/Explosion_4.png"),
      await game.images.load("explosion/Explosion_5.png"),
      await game.images.load("explosion/Explosion_6.png"),
      await game.images.load("explosion/Explosion_7.png"),
      await game.images.load("explosion/Explosion_8.png"),
      await game.images.load("explosion/Explosion_9.png"),
      await game.images.load("explosion/Explosion_10.png"),
    ];

    // Create sprites from images
    final sprites = images.map((image) => Sprite(image)).toList();

    // Create the animation from the sprites
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1, loop: false);
    resetOnRemove = true;

    // Remove the component when animation completes
    animationTicker?.onComplete = () {
      removeFromParent();
    };
  }
}
