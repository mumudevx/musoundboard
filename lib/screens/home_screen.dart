import 'package:flutter/material.dart';
import 'package:musoundboard/provider/favorite_sounds_provider.dart';
import 'package:musoundboard/screens/favorite_sounds_screen.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final AudioService audioService = AudioService();
  String filter = '';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: audioService.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            onChanged: (value) {
              setState(() {
                filter = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Search...',
            ),
          ),
          bottom: TabBar(
            tabs: audioService.tabs.map((tab) => Tab(text: tab)).toList(),
          ),
        ),
        body: TabBarView(
          children: audioService.tabs.map((tab) {
            return GridView.count(
              crossAxisCount: 3,
              children: audioService.filterSounds(filter, tab).map((sound) {
                return Container(
                    margin: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add to favorites'),
                              content: const Text(
                                  'Do you want to add this sound to your favorites?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Add'),
                                  onPressed: () {
                                    Provider.of<FavoriteSoundsProvider>(context,
                                            listen: false)
                                        .addSound(sound.assetPath);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: ElevatedButton(
                        onPressed: () async {
                          await audioService.play(sound.assetPath);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: Text(sound.name),
                      ),
                    ));
              }).toList(),
            );
          }).toList(),
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              right: 30.0,
              bottom: 80.0,
              child: FloatingActionButton(
                onPressed: () {
                  audioService.audioPlayer.stop();
                },
                child: const Icon(Icons.stop),
              ),
            ),
            Positioned(
              right: 30.0,
              bottom: 10.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteSoundsScreen()),
                  );
                },
                child: const Icon(Icons.favorite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
