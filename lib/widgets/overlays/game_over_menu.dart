import 'package:flutter/material.dart';

import '../../game/game.dart';
import '../../screens/main_menu.dart';
import 'pause_button.dart';

// This class represents the game over menu overlay.
class GameOverMenu extends StatelessWidget {
  static const String id = 'GameOverMenu';
  final AmelShipGame game;

  const GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.withValues(alpha: 0.8),
            Colors.black.withValues(alpha: 0.9),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game Over title.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow],
                ).createShader(bounds),
                child: const Text(
                  'GAME OVER',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                        color: Colors.red,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Restart button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  game.overlays.remove(GameOverMenu.id);
                  game.overlays.add(PauseButton.id);
                  game.reset();
                  game.resumeEngine();
                },
                child: const Text('Main Lagi', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 15),

            // Exit button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  game.overlays.remove(GameOverMenu.id);
                  game.reset();
                  game.resumeEngine();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MainMenu()),
                  );
                },
                child: const Text('Keluar', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
