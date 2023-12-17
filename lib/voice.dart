import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_app01/graph.dart';
import 'package:my_app01/route.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceInputWidget extends StatefulWidget {
  final Function(String, String) onGettingInput;
  late DirectedWeightedGraph uetGraph;
  VoiceInputWidget({required this.onGettingInput});
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
      print(source + "...." + destination);
      if (widget.uetGraph.vertexExists(source.toLowerCase()) &&
          widget.uetGraph.vertexExists(destination.toLowerCase())) {
        print("lomojaba");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyRoute(destination: destination, source: source)),
        );

        // widget.onGettingInput(source, destination);
      }
    });
  }

  void _onSpeakResult(result) {
    setState(() {
      if (isSource)
        source = result.recognizedWords ?? "";
      else
        destination = result.recognizedWords ?? "";
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
            print(isListening);
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
        (isSource) ? Text(source) : Text(destination),
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
