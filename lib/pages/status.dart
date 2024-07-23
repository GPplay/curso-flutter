import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:practica_1/services/socket_service.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});



  @override
  Widget build(BuildContext context) {
    
    final socketService = Provider.of<SocketService>(context);

    return const Scaffold(
      body: Center(
        child: Text('Hola Mundo'),
    ),
  );
  }
}