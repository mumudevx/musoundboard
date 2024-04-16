import 'package:flutter/material.dart';
import 'package:musoundboard/provider/favorite_sounds_provider.dart';
import 'package:musoundboard/services/audio_service.dart';
import 'package:provider/provider.dart';

class FavoriteSoundsScreen extends StatelessWidget {
  const FavoriteSoundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AudioService audioService = AudioService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Sounds'),
      ),
      body: Consumer<FavoriteSoundsProvider>(
        builder: (context, favoriteSoundsProvider, child) {
          return ListView.builder(
            itemCount: favoriteSoundsProvider.favoriteSounds.length,
            itemBuilder: (context, index) {
              final sound = favoriteSoundsProvider.favoriteSounds[index];
              return ListTile(
                title: Text(sound),
                leading: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () async {
                    await audioService.play(sound);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    favoriteSoundsProvider.removeSound(sound);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          audioService.stop();
        },
        child: const Icon(Icons.stop),
      ),
    );
  }
}
