import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'player.dart';

class HealthBar extends PositionComponent {
  final Player player;

  HealthBar({
    required this.player,
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
  });

  @override
  void render(Canvas canvas) {
    // Draws a rectangular health bar at top right corner with gradient colors.
    final healthColor = player.health > 60
        ? Colors.green
        : player.health > 30
            ? Colors.orange
            : Colors.red;
    canvas.drawRect(
      Rect.fromLTWH(-2, 5, player.health.toDouble(), 20),
      Paint()..color = healthColor,
    );
    super.render(canvas);
  }
}
