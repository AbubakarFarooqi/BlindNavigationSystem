import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputWidget extends StatefulWidget {
  @override
  _VoiceInputWidgetState createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget> {
  bool isListening = false;
  bool isSource = true;
  final SpeechToText _speechToText = SpeechToText();
  String source = "";
  String destination = "";
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() {
    _speechToText.listen(onResult: _onSpeakResult);
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() {
      isListening = false;
      isSource = !isSource;
    });
  }

  void _onSpeakResult(result) {
    setState(() {
      source = result.recognizedWords ?? "";
    });
  }

  void speakRoute(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(2.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isListening ? 'Listening...' : 'Hold and Speak',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red, // Change color as needed
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onLongPress: () async {
            if (isSource) speakRoute("Where you are?");
            _startListening();
          },
          onLongPressEnd: (LongPressEndDetails details) {
            _stopListening();
            if (!isSource) speakRoute("Where you want to go?");
          },
          child: InkResponse(
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(isListening ? 1.2 : 1.0),
              child: Icon(
                isListening ? Icons.mic : Icons.mic_none,
                color: isListening
                    ? Colors.red
                    : Colors.red, // Change color as needed
                size: isListening ? 35 : 35,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(source),
      ],
    );
  }
}
