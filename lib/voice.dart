import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputWidget extends StatefulWidget {
  @override
  _VoiceInputWidgetState createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget> {
  bool isHovered = false;
  bool isDoubleTap = false;

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeakResult);
  }

  void _stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeakResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isDoubleTap ? 'Listening...' : 'Tap and Speak',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 136, 35, 28),
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            _startListening();
            setState(() {
              isDoubleTap = !isDoubleTap;
            });
          },
          onTapUp: (TapUpDetails details) {
            _stopListening();
            setState(() {
              isDoubleTap = false;
            });
          },
          child: InkResponse(
            onTap: () {},
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(isDoubleTap ? 1.2 : 1.0),
              child: Icon(
                isDoubleTap ? Icons.mic : Icons.mic_none,
                color: isDoubleTap ? Color.fromARGB(255, 136, 35, 28) : Color.fromARGB(255, 136, 35, 28),
                size: isDoubleTap ? 35 : 35,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(_wordsSpoken),
      ],
    );
  }
}
