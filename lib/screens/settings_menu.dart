import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amel_ship/models/settings.dart';

// This class represents the settings menu.
class SettingsMenu extends StatelessWidget {
  const SettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Settings title.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.pink, Colors.purple, Colors.blue],
                  ).createShader(bounds),
                  child: const Text(
                    'PENGATURAN',
                    style: TextStyle(
                      fontSize: 45.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.purple,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Switch for sound effects.
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Selector<Settings, bool>(
                  selector: (context, settings) => settings.soundEffects,
                  builder: (context, value, child) {
                    return SwitchListTile(
                      title: const Text('Efek Suara',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: const Text('Aktifkan efek suara game',
                          style: TextStyle(color: Colors.grey)),
                      value: value,
                      activeThumbColor: Colors.cyan,
                      onChanged: (newValue) {
                        Provider.of<Settings>(context, listen: false)
                            .soundEffects = newValue;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 15),

              // Switch for background music.
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withValues(alpha: 0.3),
                ),
                child: Selector<Settings, bool>(
                  selector: (context, settings) => settings.backgroundMusic,
                  builder: (context, value, child) {
                    return SwitchListTile(
                      title: const Text('Musik Latar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      subtitle: const Text('Aktifkan musik latar',
                          style: TextStyle(color: Colors.grey)),
                      value: value,
                      activeThumbColor: Colors.pink,
                      onChanged: (newValue) {
                        Provider.of<Settings>(context, listen: false)
                            .backgroundMusic = newValue;
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              // Back button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
