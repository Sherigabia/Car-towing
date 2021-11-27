import 'package:flutter/material.dart';

class RoadAssistance extends StatefulWidget {
  const RoadAssistance({Key? key}) : super(key: key);

  @override
  _RoadAssistanceState createState() => _RoadAssistanceState();
}

class _RoadAssistanceState extends State<RoadAssistance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Road-Side Assistance")));
  }
}
