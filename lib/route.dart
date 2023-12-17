import 'package:flutter/material.dart';
import 'package:my_app01/main.dart';

class MyRoute extends StatefulWidget {
  late String source;
  late String destination;
  MyRoute({super.key, required this.destination, required this.source});

  @override
  State<MyRoute> createState() => _RouteState();
}

class _RouteState extends State<MyRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text(widget.source), Text(widget.destination)],
      ),
    );
  }
}
