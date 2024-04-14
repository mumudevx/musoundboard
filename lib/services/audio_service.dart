import 'package:audioplayers/audioplayers.dart';
import 'package:musoundboard/models/sound.dart';

class AudioService {
  final AudioPlayer audioPlayer = AudioPlayer();

  final List<String> tabs = ['Tab 1', 'Tab 2', 'Tab 3'];

  final List<Sound> sounds = [
    Sound(name: 'Sound 1', assetPath: 'sounds/sound1.mp3', tab: 'Tab 1'),
    Sound(name: 'Sound 2', assetPath: 'sounds/sound2.mp3', tab: 'Tab 2'),
    Sound(name: 'Sound 3', assetPath: 'sounds/sound3.mp3', tab: 'Tab 3'),
  ];

  Future<void> play(String assetPath) async {
    await audioPlayer.play(AssetSource(assetPath));
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  List<Sound> filterSounds(String filter, String tab) {
    return sounds.where((sound) {
      return sound.name.toLowerCase().contains(filter.toLowerCase()) &&
          sound.tab == tab;
    }).toList();
  }
}
