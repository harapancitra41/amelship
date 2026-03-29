import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'enemy.dart';

// This component represent a bullet in game world.
class Bullet extends SpriteComponent with CollisionCallbacks {
  // Speed of the bullet.
  final double _speed = 450;

  // Controls the direction in which bullet travels.
  Vector2 direction = Vector2(0, -1);

  // Level of this bullet. Essentially represents the
  // level of spaceship that fired this bullet.
  final int level;

  // Weapon type: 0 = normal, 1 = laser (red), 2 = plasma (cyan), 3 = fire (orange)
  final int weaponType;

  // Color for rendering based on weapon type
  Color get bulletColor {
    switch (weaponType) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.cyan;
      case 3:
        return Colors.orange;
      default:
        return Colors.white;
    }
  }

  // Damage multiplier based on weapon type
  int get damageMultiplier {
    switch (weaponType) {
      case 1:
        return 2; // Laser does double damage
      case 2:
        return 1; // Plasma does normal damage but is larger
      case 3:
        return 3; // Fire does triple damage
      default:
        return 1;
    }
  }

  Bullet({
    required super.sprite,
    required super.position,
    required super.size,
    required this.level,
    this.weaponType = 0,
  });

  @override
  void render(Canvas canvas) {
    // Draw colored aura based on weapon type
    if (weaponType > 0) {
      final auraPaint = Paint()
        ..color = bulletColor.withValues(alpha: 0.3)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(size.x / 2, size.y / 2),
        weaponType == 2 ? 20 : 15, // Plasma is larger
        auraPaint,
      );
    }
    super.render(canvas);
  }

  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.4 times
    //  the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // If the other Collidable is Enemy, remove this bullet.
    if (other is Enemy) {
      // Apply damage based on weapon type
      other.takeDamage(level * 10 * damageMultiplier);

      // Plasma penetrates, doesn't get removed
      if (weaponType != 2) {
        removeFromParent();
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Fire weapon moves faster
    double speed = weaponType == 1 ? _speed * 1.5 : _speed;

    // Moves the bullet to a new position with _speed and direction.
    position += direction * speed * dt;

    // If bullet crosses the upper boundary of screen
    // mark it to be removed it from the game world.
    if (position.y < 0) {
      removeFromParent();
    }
  }
}

