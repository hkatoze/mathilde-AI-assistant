import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();
  FlutterTts flutterTts = FlutterTts();

  double speechRate = 0.55;
  String voice = 'Voice 1';

  static initTTS() async {
    tts.setLanguage("en-EN");
    tts.setPitch(1.2);
  }

  static stop() async {
    tts.stop();
    print('TTS  IS STOPPED');
  }

  static speak(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tts.setSpeechRate(prefs.getDouble('speech_rate') ?? 0.55);
    tts.setPitch(prefs.getDouble('voice') ?? 1.2);
    tts.setStartHandler(() {
      print('TTS  IS STARTED');
    });

    tts.setCompletionHandler(() {
      print("COMPLETED");
    });
    tts.setErrorHandler((message) {
      print(message);
    });
    await tts.awaitSpeakCompletion(true);
    tts.speak(text);
  }
}
