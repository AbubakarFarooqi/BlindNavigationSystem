import 'package:flutter/material.dart';
import 'voice.dart';

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
      theme: ThemeData(
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
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
      body: 
      Padding(
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
                child: Column(children: [
                  Source(controller: _sourceCantroller),
                  SizedBox(height: 10),
                  Destination(controller: _destinationController),
                  SizedBox(height: 10),
                ],)
              ),
            ),
            SizedBox(height: 30),
            VoiceInputWidget(),
          ],
        ),
      ),
      floatingActionButton: MapIconWidget(),
    );
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

  Source ({required this.controller});

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


