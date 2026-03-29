import 'package:flutter/material.dart';

import '../../game/game.dart';
import 'pause_menu.dart';

// This class represents the pause button overlay.
class PauseButton extends StatelessWidget {
  static const String id = 'PauseButton';
  final AmelShipGame game;

  const PauseButton({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.cyan, width: 1),
        ),
        child: TextButton(
          child: const Icon(Icons.pause_rounded, color: Colors.cyan, size: 30),
          onPressed: () {
            game.pauseEngine();
            game.overlays.add(PauseMenu.id);
            game.overlays.remove(PauseButton.id);
          },
        ),
      ),
    );
  }
}
