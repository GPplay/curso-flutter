// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:practica_1/models/band.dart';
import 'package:practica_1/services/socket_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List<Band> bands = [];

  @override
  void initState() {

    final socketService = Provider.of<SocketService>(context , listen: false);

    socketService.socket.on('heroes-activos', (payload) {
      _handelActiveBands(payload);
    });

    super.initState();
    
  }


_handelActiveBands( dynamic payload ){
        bands = (payload as List).map( (banda) => Band.fromMap(banda) ).toList();

      setState(() {});
}
  //cuando se vaya a destruir el HOME se llama el dispose

  /*
   *  @overrode
   *  void dipose(){
   *  final socketService = Provider.of<SocketService>(context , listen: false);
   *  
   *  socketService.socket.off('un evento');
   * 
   *  super.dispose();
   * }
   */

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Heroe', style: TextStyle(color: Colors.black87 ),),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            //TODO hacer un ternario para que uno funcione si el servidor esta conectado o no
            
            child: ( socketService.serverStatus == ServerStatus.connected) ?
            Icon( Icons.check_circle, color: Colors.green[400], ):
            Icon( Icons.offline_bolt, color: Colors.red[400], )
          )
        ],
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

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: ( _ )=>socketService.socket.emit('delete-heroe', {'id' : band.id}), //TODO: llamar el borrado en el server (hecho)
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
            socketService.socket.emit('vote-heroe', {'id': band.id});
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
    final socketService = Provider.of<SocketService>(context, listen: false);
    if(name.length > 1){
      //se agrega nueva banda
      //emitir "add-heroe" {"name" : nombre}
      socketService.socket.emit('add-heroe', {'name' : name});
    }
    Navigator.pop(context);
  }
}