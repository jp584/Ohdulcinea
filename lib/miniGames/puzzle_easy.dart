import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/dulcineaController.dart';
import '../enums/map_id.dart';
import '../games/dulcinea_game.dart';

class PuzzleEasy extends StatelessWidget {
  const PuzzleEasy({Key? key}) : super(key: key);

  static const String id = 'puzzle_easy'; // ID FOR THE SCREEN

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(title: Text('Mensaje de la app'),
        ),
        body: Stack(
            children: [
              Align(
                  alignment: Alignment(-1, -1),
                  child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: RadialGradient(colors: [
                            Colors.teal.shade100,
                            Colors.teal.shade900
                          ]),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(child: Text('Uno', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.green))))
              ),
              Align(
                  alignment: Alignment(0, -1),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Dos', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.red))))
              ),
              Align(
                  alignment: Alignment(1, -1),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Tres', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.deepOrange))))
              ),
              Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Cuatro', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.teal))))
              ),
              Align(
                  alignment: Alignment(0, 0),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Cinco', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.white12))))
              ),
              Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Seis', style: TextStyle(
                          fontSize: 20,
                          backgroundColor: Colors.deepOrangeAccent))))
              ),
              Align(
                  alignment: Alignment(-1, 1),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Siete', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.deepPurple))))
              ),
              Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: Center(child: Text('Ocho', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.pink))))
              ),
              Align(
                  alignment: const Alignment(1, 1),
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.amber,
                      child: const Center(child: Text('Nueve', style: TextStyle(
                          fontSize: 20, backgroundColor: Colors.orange))))
              ),
              const SizedBox(height: 100,),
              ElevatedButton( // HOW TO RETURN TO FIRST MAP
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Volver al mapa')
              )
            ]
        ),
      ),
    );
  }

}