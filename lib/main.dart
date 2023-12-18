import 'package:flutter/material.dart';
import 'package:my_app01/graph.dart';
import 'package:my_app01/route.dart';
import 'voice.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

TextEditingController _sourceCantroller = TextEditingController();
TextEditingController _destinationController = TextEditingController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blind Navigation',
      color: Colors.white,
      theme: ThemeData(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  late DirectedWeightedGraph uetGraph;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = FlutterTts();
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    loadUetGraph();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Blind Navigation',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        leading: const Icon(
          Icons.sort_rounded,
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 209, 54, 42),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'WELCOME TO UET',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 209, 54, 42),
              ),
            ),
            SizedBox(height: 50),
            Text(
              'Enter the Source and the Destination or Speak it Instead',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15, width: 450),
            Center(
              child: Container(
                  width: 350,
                  child: Column(
                    children: [
                      Source(controller: _sourceCantroller),
                      SizedBox(height: 10),
                      Destination(controller: _destinationController),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyRoute(
                              source: _sourceCantroller.text,
                              destination: _destinationController.text,
                            )),
                  );
                },
                child: Text("Go")),
            SizedBox(height: 30),
            VoiceInputWidget(),
          ],
        ),
      ),
      floatingActionButton: MapIconWidget(),
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

  void speakRoute({required String source, required String destination}) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setPitch(2.0);
    await flutterTts
        .speak("You are at " + source + " and going to " + destination);
  }
}

class MapIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
        ),
      ),
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Show UET Map',
        child: Icon(Icons.map),
        backgroundColor: Color.fromARGB(255, 209, 54, 42),
      ),
    );
  }
}

class Source extends StatelessWidget {
  final TextEditingController controller;

  Source({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your Location',
        labelText: 'Source',
        prefixIcon: Icon(Icons.location_city),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class Destination extends StatelessWidget {
  final TextEditingController controller;

  Destination({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Enter your Destination',
        labelText: 'Destination',
        prefixIcon: Icon(Icons.map_rounded),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
