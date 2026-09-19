import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText _speech = SpeechToText();

  Future<bool> init() => _speech.initialize();

  Future<void> listen({
    required void Function(String text) onText,
  }) async {
    final available = await init();
    if (!available) return;

    await _speech.listen(
      localeId: 'es_PE',
      onResult: (result) => onText(result.recognizedWords),
    );
  }

  Future<void> stop() => _speech.stop();

  bool get isListening => _speech.isListening;
}
