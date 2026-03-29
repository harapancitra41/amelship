import 'package:flutter/material.dart';

import 'settings_menu.dart';
import 'select_spaceship.dart';

// Represents the main menu screen of Amel Ship, allowing
// players to start the game or modify in-game settings.
class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A0533),
              Color(0xFF4A0E4E),
              Color(0xFF0D1B2A),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game title.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.cyan, Colors.pink, Colors.orange, Colors.yellow],
                  ).createShader(bounds),
                  child: const Text(
                    'AMELSHIP',
                    style: TextStyle(
                      fontSize: 55.0,
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

              // Play button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.pink, width: 2),
                    ),
                  ),
                  onPressed: () {
                    // Push and replace current screen (i.e MainMenu) with
                    // SelectSpaceship(), so that player can select a spaceship.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const SelectSpaceship(),
                      ),
                    );
                  },
                  child: const Text('Main', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),

              const SizedBox(height: 20),

              // Settings button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.cyan, width: 2),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SettingsMenu(),
                      ),
                    );
                  },
                  child: const Text('Pengaturan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
