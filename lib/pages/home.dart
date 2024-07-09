// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

//import 'package:flutter/cupertino.dart';
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

  Widget _bandtile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction ){
        debugPrint('Direcion: $direction');
        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only( left: 8.0),
        color: Colors.red[300],
        child: const Align (
          alignment: Alignment.centerLeft,
          child: Text('BORRAR HEROE', style: TextStyle(color: Colors.white),)
        ),
        ),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[100],
            child: Text(band.name?.substring(0, 2) ?? ""),
          ),
          title: Text( band.name! ),
          trailing: Text('${band.vote}', style: const TextStyle(fontSize: 20),),
          onTap: () {
            debugPrint(band.name);
            },
        ),
    );
  }
  addNewBand(){
    final textController = TextEditingController();
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
  

/*   //para iphone
  showCupertinoDialog(
    context: context, 
    builder: (_){
      return CupertinoAlertDialog(
        title: const Text('Nuevo heroe'),
        content: CupertinoTextField(
          controller: textController,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Añadir'),
            onPressed: () => addBandToList(textController.text),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('cerrar'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    }
    ); */
  }

  void addBandToList(String name){
    if(name.length > 1){
      //se agrega nueva banda
      bands.add(Band(id: DateTime.now().toString(), name: name, vote: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}