import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_app01/graph.dart';
import 'package:my_app01/route.dart';
import 'package:my_app01/voice2.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputWidget extends StatefulWidget {
  late DirectedWeightedGraph uetGraph;
  @override
  _VoiceInputWidgetState createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget> {
  bool isListening = false;
  final SpeechToText _speechToText = SpeechToText();
  String source = "";
  FlutterTts flutterTts = FlutterTts();
  void setState(VoidCallback fn) {
    // TODO: implement setState
    loadUetGraph();
  }

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeakResult);
    setState(() {
      isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      isListening = false;
    });
    print(source + "....");
    if (widget.uetGraph.vertexExists(source.toLowerCase())) {
      print("lomojaba");
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VoiceInput2Widget(source: source)),
      );

      // widget.onGettingInput(source, destination);
    }
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
            // speakRoute("Where you are?");
            _startListening();
          },
          onLongPressEnd: (LongPressEndDetails details) {
            print(isListening);
            _stopListening();
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

  void loadUetGraph() {
    widget.uetGraph = DirectedWeightedGraph();
    widget.uetGraph.addVertex("gate 3");
    widget.uetGraph.addVertex("junction");
    widget.uetGraph.addVertex("kiks department");
    widget.uetGraph.addVertex("electrical engineering department");
    widget.uetGraph.addVertex("main library");
    widget.uetGraph.addVertex("civil department");
    widget.uetGraph.addVertex("computer science department");

    widget.uetGraph.addEdge("gate 3", "junction", 5, "n");
    widget.uetGraph.addEdge("junction", "gate 3", 5, "s");

    widget.uetGraph.addEdge("junction", "kiks department", 10, "e");
    widget.uetGraph.addEdge("kiks department", "junction", 10, "w");

    widget.uetGraph
        .addEdge("electrical engineering department", "junction", 3, "w");
    widget.uetGraph
        .addEdge("junction", "electrical engineering department", 3, "e");

    widget.uetGraph.addEdge("junction", "main library", 11, "n");
    widget.uetGraph.addEdge("main library", "junction", 11, "s");

    widget.uetGraph.addEdge("main library", "civil department", 12, "e");
    widget.uetGraph.addEdge("civil department", "main library", 12, "w");

    widget.uetGraph
        .addEdge("civil department", "computer science department", 13, "e");
    widget.uetGraph
        .addEdge("computer science department", "civil department", 13, "w");
  }
}
