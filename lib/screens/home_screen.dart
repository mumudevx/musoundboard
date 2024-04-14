import 'package:flutter/material.dart';
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
                );
              }).toList(),
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            audioService.audioPlayer.stop();
          },
          child: const Icon(Icons.stop),
        ),
      ),
    );
  }
}
