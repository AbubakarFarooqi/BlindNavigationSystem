import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_app01/graph.dart';
import 'package:my_app01/main.dart';

class MyRoute extends StatefulWidget {
  late String source;
  late String destination;
  late DirectedWeightedGraph uetGraph;
  var path;
  late int steps;
  late int i;
  MyRoute({super.key, required this.destination, required this.source});

  @override
  State<MyRoute> createState() => _RouteState();
}

class _RouteState extends State<MyRoute> {
  FlutterTts flutterTts = FlutterTts();

  void speakRoute({required String source}) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.setPitch(2.0);
    await flutterTts.speak(source);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUetGraph();
    print("azan");
    widget.path = widget.uetGraph.ucs(widget.source, widget.destination);
    print(widget.path);
    widget.i = 0;
    widget.steps = widget.path[widget.i]["weight"];
    speakRoute(
        source: "Go " +
            widget.steps.toString() +
            " steps " +
            widget.path[widget.i]["direction"] +
            " towards " +
            widget.path[widget.i]["to"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.steps.toString()),
          ElevatedButton(
              onPressed: () {
                if (widget.i == widget.path.length) {
                  speakRoute(source: "You Have reached your destination");
                } else if (widget.steps == 0) {
                  setState(() {
                    widget.i = widget.i + 1;
                    // if (widget.i >= widget.path.length()) {}
                    print("Azan" + widget.i.toString());
                    widget.steps = widget.path[widget.i]["weight"];
                    speakRoute(
                        source: "Go " +
                            widget.steps.toString() +
                            " steps " +
                            widget.path[widget.i]["direction"] +
                            " towards " +
                            widget.path[widget.i]["to"]);
                  });
                } else {
                  setState(() {
                    widget.steps = widget.steps - 1;
                  });
                }
              },
              child: Text("count"))
        ],
      ),
    ));
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

    widget.uetGraph.addEdge("gate 3", "junction", 5, "north");
    widget.uetGraph.addEdge("junction", "gate 3", 5, "south");

    widget.uetGraph.addEdge("junction", "kiks department", 10, "east");
    widget.uetGraph.addEdge("kiks department", "junction", 10, "west");

    widget.uetGraph
        .addEdge("electrical engineering department", "junction", 3, "west");
    widget.uetGraph
        .addEdge("junction", "electrical engineering department", 3, "east");

    widget.uetGraph.addEdge("junction", "main library", 11, "north");
    widget.uetGraph.addEdge("main library", "junction", 11, "south");

    widget.uetGraph.addEdge("main library", "civil department", 12, "east");
    widget.uetGraph.addEdge("civil department", "main library", 12, "west");

    widget.uetGraph
        .addEdge("civil department", "computer science department", 13, "east");
    widget.uetGraph
        .addEdge("computer science department", "civil department", 13, "west");
  }
}
