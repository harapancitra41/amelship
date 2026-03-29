import 'package:flutter/material.dart';

import '../../game/game.dart';
import '../../screens/main_menu.dart';
import 'pause_button.dart';

// This class represents the pause menu overlay.
class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final AmelShipGame game;

  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.purple.withValues(alpha: 0.5),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pause menu title.
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.cyan, Colors.pink, Colors.yellow],
                ).createShader(bounds),
                child: const Text(
                  'JEDA',
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 30.0,
                        color: Colors.purple,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Resume button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  game.resumeEngine();
                  game.overlays.remove(PauseMenu.id);
                  game.overlays.add(PauseButton.id);
                },
                child: const Text('Lanjutkan', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 15),

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
                  game.overlays.remove(PauseMenu.id);
                  game.overlays.add(PauseButton.id);
                  game.reset();
                  game.resumeEngine();
                },
                child: const Text('Mulai Ulang', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 15),

            // Exit button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  game.overlays.remove(PauseMenu.id);
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
