import 'package:flutter/material.dart';
import 'package:practica_1/models/band.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Band> bands = [
    Band(id: '1', name: 'batman', vote: 55),
    Band(id: '1', name: 'superman', vote: 25),
    Band(id: '1', name: 'iroman', vote: 5),
    Band(id: '1', name: 'megaman', vote: 15),
  ];


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('hola mundo')
      ),
    );
  }
}