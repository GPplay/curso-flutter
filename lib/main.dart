import 'package:flutter/material.dart';
import 'package:practica_1/services/socket_service.dart';
import 'package:provider/provider.dart';

import 'package:practica_1/pages/home.dart';
import 'package:practica_1/pages/status.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => SocketService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quien gana en un VS votacion',
        initialRoute: 'status',
        routes: {
          'home' :(_) => HomePage(),
          'status': ( _ ) =>const StatusPage()
        }
      ),
    );
  }
}