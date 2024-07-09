// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Heroe', style: TextStyle(color: Colors.black87 ),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandtile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add)
      ),
    );
  }

  ListTile _bandtile(Band band) {
    return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name?.substring(0, 2) ?? ""),
        ),
        title: Text( band.name! ),
        trailing: Text('${band.vote}', style: const TextStyle(fontSize: 20),),
        onTap: () {
          debugPrint(band.name);
          },
      );
  }
  addNewBand(){
    final textController = TextEditingController();

  if(Platform.isAndroid){
    //Android
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nuevo super herore:'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              // ignore: sort_child_properties_last
              child: const Text('Añadir'),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text)
              )
            ],
        );
      }
    );
  }
  showCupertinoDialog(
    context: context, 
    builder: (_){
      return CupertinoAlertDialog(
        title: Text('Nuevo heroe'),
        content: CupertinoTextField(
          controller: textController,
        ),
      );
    }
    );
  }

  void addBandToList(String name){

    debugPrint(name);

    if(name.length > 1){
      //se agrega nueva banda
    }

    Navigator.pop(context);

  }
}