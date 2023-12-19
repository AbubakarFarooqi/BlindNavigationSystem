import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:my_app01/graph.dart';
import 'package:my_app01/route.dart';
import 'package:my_app01/voice2.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'helpers.dart';

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
    widget.uetGraph.addVertex("environmental engineering department");
    widget.uetGraph.addVertex("electrical engineering department");
    widget.uetGraph.addVertex("main library");
    widget.uetGraph.addVertex("library golchakar");
    widget.uetGraph.addVertex("architecture department");
    widget.uetGraph.addVertex("city and regional planning");
    widget.uetGraph.addVertex("masjid chowk");
    widget.uetGraph.addVertex("islamic department");
    widget.uetGraph.addVertex("lalazar chowk");
    widget.uetGraph.addVertex("admin block");
    widget.uetGraph.addVertex("pid department");
    widget.uetGraph.addVertex("architecture engineering department");
    widget.uetGraph.addVertex("laser and optics centert");
    widget.uetGraph.addVertex("star photoshop");
    widget.uetGraph.addVertex("bus stand chowk");
    widget.uetGraph.addVertex("ibm deprtment");
    widget.uetGraph.addVertex("ibm chowk");
    widget.uetGraph.addVertex("bssc");
    widget.uetGraph.addVertex("security office chowk");
    widget.uetGraph.addVertex("bhola caffe");
    widget.uetGraph.addVertex("junaid jamshed garden");
    widget.uetGraph.addVertex("jj chowk");
    widget.uetGraph.addVertex("humanities department");
    widget.uetGraph.addVertex("chemical engineering department");
    widget.uetGraph.addVertex("chemical engineering chowk");
    widget.uetGraph.addVertex("petroleum and mining department");
    widget.uetGraph.addVertex("notice chowk");
    widget.uetGraph.addVertex("polymer department");
    widget.uetGraph.addVertex("lecture threater");
    widget.uetGraph.addVertex("civil department");
    widget.uetGraph.addVertex("transportation department");
    widget.uetGraph.addVertex("computer science department");
    widget.uetGraph.addVertex("gssc chowk");
    widget.uetGraph.addVertex("computer engineering department");
    widget.uetGraph.addVertex("maths department");
    widget.uetGraph.addVertex("mechatronics department");
    widget.uetGraph.addVertex("kics department");

    widget.uetGraph.addEdge("gate 3", "electrical engineering department", 40, "north");
    widget.uetGraph.addEdge("electrical engineering department", "gate 3", 40, "south");

    widget.uetGraph.addEdge("electrical engineering department", "environmental engineering department", 10, "north");
    widget.uetGraph.addEdge("environmental engineering department", "electrical engineering department", 10, "south");

    widget.uetGraph.addEdge("environmental engineering department", "main library", 180, "north");
    widget.uetGraph.addEdge("main library", "environmental engineering department", 180, "south");

    widget.uetGraph.addEdge("main library", "library golchakar", 35, "north");
    widget.uetGraph.addEdge("library golchakar", "main library", 35, "south");

    widget.uetGraph.addEdge("library golchakar", "architecture department", 35, "west");
    widget.uetGraph.addEdge("architecture department", "library golchakar", 35, "east");

    widget.uetGraph.addEdge("architecture department", "city and regional planning", 50, "west");
    widget.uetGraph.addEdge("city and regional planning", "architecture department", 50, "east");

    widget.uetGraph.addEdge("city and regional planning", "masjid chowk", 40, "west");
    widget.uetGraph.addEdge("masjid chowk", "city and regional planning", 40, "east");

    widget.uetGraph.addEdge("masjid chowk", "islamic department", 110, "south");
    widget.uetGraph.addEdge("islamic department", "masjid chowk", 110, "north");

    widget.uetGraph.addEdge("islamic department", "lalazar chowk", 50, "south");
    widget.uetGraph.addEdge("lalazar chowk", "islamic department", 50, "north");

    widget.uetGraph.addEdge("lalazar chowk", "admin block", 60, "south");
    widget.uetGraph.addEdge("admin block", "lalazar chowk", 60, "north");

    widget.uetGraph.addEdge("admin block", "pid department", 55, "west");
    widget.uetGraph.addEdge("pid department", "admin block", 55, "east");

    widget.uetGraph.addEdge("pid department", "architecture engineering department", 30, "west");
    widget.uetGraph.addEdge("architecture engineering department", "pid department", 30, "east");

    widget.uetGraph.addEdge("architecture engineering department", "laser and optics centert", 5, "west");
    widget.uetGraph.addEdge("laser and optics centert", "architecture engineering department", 5, "east");

    widget.uetGraph.addEdge("laser and optics centert", "star photoshop", 50, "west");
    widget.uetGraph.addEdge("star photoshop", "laser and optics centert", 50, "east");

    widget.uetGraph.addEdge("star photoshop", "bus stand chowk", 160, "north");
    widget.uetGraph.addEdge("bus stand chowk", "star photoshop", 160, "south");

    widget.uetGraph.addEdge("bus stand chowk", "masjid chowk", 60, "east");
    widget.uetGraph.addEdge("masjid chowk", "bus stand chowk", 60, "west");

    widget.uetGraph.addEdge("masjid chowk", "ibm deprtment", 50, "west");
    widget.uetGraph.addEdge("ibm deprtment", "masjid chowk", 50, "east");

    widget.uetGraph.addEdge("ibm deprtment", "ibm chowk", 20, "west");
    widget.uetGraph.addEdge("ibm chowk", "ibm deprtment", 20, "east");

    widget.uetGraph.addEdge("ibm chowk", "bssc", 35, "west");
    widget.uetGraph.addEdge("bssc", "ibm chowk", 35, "east");

    widget.uetGraph.addEdge("ibm chowk", "security office chowk", 250, "north");
    widget.uetGraph.addEdge("security office chowk", "ibm chowk", 250, "south");

    widget.uetGraph.addEdge("security office chowk", "bhola caffe", 100, "east");
    widget.uetGraph.addEdge("bhola caffe", "security office chowk", 100, "west");

    widget.uetGraph.addEdge("bhola caffe", "junaid jamshed garden", 90, "east");
    widget.uetGraph.addEdge("junaid jamshed garden", "bhola caffe", 90, "west");

    widget.uetGraph.addEdge("junaid jamshed garden", "jj chowk", 40, "east");
    widget.uetGraph.addEdge("jj chowk", "junaid jamshed garden", 40, "west");

    widget.uetGraph.addEdge("jj chowk", "humanities department", 40, "east");
    widget.uetGraph.addEdge("humanities department", "jj chowk", 40, "west");

    widget.uetGraph.addEdge("humanities department", "chemical engineering department", 50, "east");
    widget.uetGraph.addEdge("chemical engineering department", "humanities department", 50, "west");

    widget.uetGraph.addEdge("chemical engineering department", "chemical engineering chowk", 50, "east");
    widget.uetGraph.addEdge("chemical engineering chowk", "chemical engineering department", 50, "west");

    widget.uetGraph.addEdge("chemical engineering chowk", "petroleum and mining department", 95, "south");
    widget.uetGraph.addEdge("petroleum and mining department", "chemical engineering chowk", 95, "north");

    widget.uetGraph.addEdge("petroleum and mining department", "notice chowk", 55, "south west");
    widget.uetGraph.addEdge("notice chowk", "petroleum and mining department", 95, "north east");

    widget.uetGraph.addEdge("notice chowk", "polymer department", 40, "west");
    widget.uetGraph.addEdge("polymer department", "notice chowk", 40, "east");

    widget.uetGraph.addEdge("polymer department", "library golchakar", 120, "south");
    widget.uetGraph.addEdge("library golchakar", "polymer department", 120, "north");

    widget.uetGraph.addEdge("library golchakar", "lecture threater", 65, "east");
    widget.uetGraph.addEdge("lecture threater", "library golchakar", 65, "west");

    widget.uetGraph.addEdge("lecture threater", "computer science department", 65, "east");
    widget.uetGraph.addEdge("computer science department", "lecture threater", 65, "west");

    widget.uetGraph.addEdge("lecture threater", "civil department", 65, "east");
    widget.uetGraph.addEdge("civil department", "lecture threater", 65, "west");

    widget.uetGraph.addEdge("civil department", "transportation department", 70, "east");
    widget.uetGraph.addEdge("transportation department", "civil department", 70, "west");

    widget.uetGraph.addEdge("lecture threater", "transportation department", 70, "east");
    widget.uetGraph.addEdge("transportation department", "lecture threater", 70, "west");

    widget.uetGraph.addEdge("computer science department", "transportation department", 70, "east");
    widget.uetGraph.addEdge("transportation department", "computer science department", 70, "west");

    widget.uetGraph.addEdge("transportation department", "gssc chowk", 50, "east");
    widget.uetGraph.addEdge("gssc chowk", "transportation department", 50, "west");

    widget.uetGraph.addEdge("gssc chowk", "maths department", 50, "south");
    widget.uetGraph.addEdge("maths department", "gssc chowk", 50, "north");

    widget.uetGraph.addEdge("maths department", "computer engineering department", 10, "north");
    widget.uetGraph.addEdge("computer engineering department", "maths department", 10, "south");

    widget.uetGraph.addEdge("computer engineering department", "kics department", 50, "south");
    widget.uetGraph.addEdge("kics department", "computer engineering department", 50, "north");

    widget.uetGraph.addEdge("kics department", "mechatronics department", 50, "south");
    widget.uetGraph.addEdge("mechatronics department", "kics department", 50, "north");



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

class VoiceInputWidget extends StatefulWidget {
  late DirectedWeightedGraph uetGraph;

  @override
  _VoiceInputWidgetState createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget> {
  bool isListening = false;
  final SpeechToText _speechToText = SpeechToText();
  String source = "";
  String destination = "";
  FlutterTts flutterTts = FlutterTts();
  int clickCount = 0;

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

    if (widget.uetGraph.vertexExists(source.toLowerCase())) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VoiceInput2Widget(source: source),
        ),
      );
    }
  }

  void _onSpeakResult(result) {
    setState(() {
      if (clickCount % 2 != 0) {
        source = result.recognizedWords ?? "";
        send_source(source);
      } else if (clickCount % 2 == 0) {
        destination = result.recognizedWords ?? "";
        send_destination(destination);
      }
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
            color: Colors.red,
          ),
        ),
        SizedBox(height: 15),
        GestureDetector(
          onLongPress: () async {
            setState(() {
              clickCount = clickCount + 1;
            });
            if (clickCount % 2 != 0) {
              speakRoute('Tell me where you are?');
              setState(() {
                isListening = true;
              });
            } else if (clickCount % 2 == 0) {
              speakRoute('Tell me your destination');
            }
            await Future.delayed(Duration(seconds: 1));
            _startListening();
          },
          onLongPressEnd: (LongPressEndDetails details) {
            setState(() {
              isListening = false;
            });
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
                color: Colors.red,
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

  void send_source(String source) {
    source = convertToLowercase(source);
    _sourceCantroller.text = "";
    _sourceCantroller.text = source;
    print(_sourceCantroller.text);
    print('///////////////////////////');
    print(source);
  }

  void send_destination(String destination) {
    destination = convertToLowercase(destination);
    _destinationController.text = "";
    _destinationController.text = destination;
    print(_sourceCantroller.text);
    print('///////////////////////////');
    print(destination);
  }

  String convertToLowercase(String input) {
    return input.toLowerCase();
  }
}
