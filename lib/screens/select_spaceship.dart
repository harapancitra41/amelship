import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/player_data.dart';
import '../models/spaceship_details.dart';

import 'game_play.dart';
import 'main_menu.dart';

// Represents the spaceship selection menu from where player can
// change current spaceship or buy a new one.
class SelectSpaceship extends StatelessWidget {
  const SelectSpaceship({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
              Color(0xFF415A77),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game title.
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.cyan, Colors.blue, Colors.purple],
                  ).createShader(bounds),
                  child: const Text(
                    'PILIH KAPAL',
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.cyan,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Displays current spaceship's name and amount of money left.
              Consumer<PlayerData>(
                builder: (context, playerData, child) {
                  final spaceship = Spaceship.getSpaceshipByType(
                    playerData.spaceshipType,
                  );
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Kapal: ${spaceship.name}', style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 20),
                        Text('Uang: \$${playerData.money}', style: const TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 250,
                child: CarouselSlider.builder(
                  itemCount: Spaceship.spaceships.length,
                  slideBuilder: (index) {
                    final spaceship =
                        Spaceship.spaceships.entries.elementAt(index).value;

                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.purple.withValues(alpha: 0.3),
                            Colors.blue.withValues(alpha: 0.3),
                          ],
                        ),
                        border: Border.all(color: Colors.cyan, width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(spaceship.assetPath, scale: 1.2),
                          const SizedBox(height: 2),
                          Text(spaceship.name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Kecepatan: ${spaceship.speed} | Lv: ${spaceship.level}', style: const TextStyle(color: Colors.grey, fontSize: 9)),
                          Text('Harga: \$${spaceship.cost}', style: const TextStyle(color: Colors.yellow, fontSize: 10)),
                          const SizedBox(height: 2),
                          Consumer<PlayerData>(
                            builder: (context, playerData, child) {
                              final type =
                                  Spaceship.spaceships.entries.elementAt(index).key;
                              final isEquipped = playerData.isEquipped(type);
                              final isOwned = playerData.isOwned(type);
                              final canBuy = playerData.canBuy(type);

                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isEquipped ? Colors.green : (isOwned ? Colors.blue : Colors.orange),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: isEquipped
                                    ? null
                                    : () {
                                        if (isOwned) {
                                          playerData.equip(type);
                                        } else {
                                          if (canBuy) {
                                            playerData.buy(type);
                                          } else {
                                            // Displays an alert if player
                                            // does not have enough money.
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.red.shade900,
                                                  title: const Text(
                                                    'Saldo Tidak Cukup',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  content: Text(
                                                    'Butuh \$${spaceship.cost - playerData.money} lagi',
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(color: Colors.white),
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        }
                                      },
                                child: Text(
                                  isEquipped
                                      ? 'Dipilih'
                                      : isOwned
                                          ? 'Pilih'
                                          : 'Beli',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Start button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: const BorderSide(color: Colors.cyan, width: 2),
                    ),
                  ),
                  onPressed: () {
                    // Push and replace current screen (i.e MainMenu) with
                    // GamePlay, because back press will be blocked by GamePlay.
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const GamePlay()),
                    );
                  },
                  child: const Text('MULAI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),

              const SizedBox(height: 15),

              // Back button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
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
