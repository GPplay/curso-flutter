// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:practica_1/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});



  @override
  Widget build(BuildContext context) {
    
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('estado del servidor: ${ socketService.serverStatus }')
          ],
        ),
    ),
  );
  }
}