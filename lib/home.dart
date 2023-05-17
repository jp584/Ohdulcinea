import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class WhackAMoleGame extends StatefulWidget {
  const WhackAMoleGame({super.key});

  @override
  _WhackAMoleGameState createState() => _WhackAMoleGameState();
}

class _WhackAMoleGameState extends State<WhackAMoleGame> {
  List<bool> _gameBoard = List.filled(9, false);
  int _totalMoles = 0;
  int _totalHits = 0;
  bool _gameOver = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startGame() {
    _gameBoard = List.filled(9, false);
    _totalMoles = 0;
    _totalHits = 0;
    _gameOver = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _generateMole();
    });
  }

  void _endGame() {
    _timer.cancel();
    setState(() {
      _gameOver = true;
    });
  }

  void _generateMole() {
    Random random = Random();
    int index = random.nextInt(9);
    setState(() {
      _gameBoard[index] = true;
      Future.delayed(const Duration(seconds: 5), () {
        if (!_gameOver) {
          setState(() {
            _gameBoard[index] = false;
          });
        }
      });
    });
  }

  //TODO agregar el efecto de sonido cuando se golpea al quijote
  void _hitMole(int index) {
    setState(() {
      _gameBoard[index] = false;
      _totalHits++;

      if (_totalHits >= 10) {
        _endGame();
        _gameBoard = List.filled(9, false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Has ganado!"),
                content: const Text(
                    "La introducción es la parte inicial de un texto, sin importar la temática o el tipo de texto que estemos escribiendo."),
                actions: <Widget>[
                  TextButton(
                    child: const Text("Cerrar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        //_totalHits = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        title: const Text("Whack-a-Mole"),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                /*
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _gameBoard[index] ? Colors.red : Colors.black,
                    minimumSize: const Size(80, 80),
                  ),
                  /*
                  onPressed: _gameOver
                      ? null
                      : () {
                      _hitMole(index);

                  },
                  */
                  onPressed: () {
                    if (_gameBoard[index]) {
                      setState(() {
                          _hitMole(index);
                      });
                    }
                  },
                  child: Container(),
                );
                */
                //reemplazo
                /*
                return ElevatedButton(
                  onPressed: () {
                    if (_gameBoard[index]) {
                      setState(() {
                        _hitMole(index);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green.shade300, backgroundColor: Colors.green.shade300,
                    minimumSize: const Size(80, 80),
                  ),
                  child: _gameBoard[index]
                      ? Image.network('https://www.bbva.com/wp-content/uploads/2016/03/don-quijote-de-la-mancha-1920x0-c-f-1.jpg')//boton a golpear
                      : Image.network('https://insulabaranaria.files.wordpress.com/2012/08/imagenquijote1.jpg'),//no golpeable
                );
*/
                return ElevatedButton(
                  onPressed: () {
                    if (_gameBoard[index]) {
                      setState(() {
                        _hitMole(index);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green.shade300,
                    backgroundColor: Colors.green.shade300,
                    minimumSize: const Size(80, 80),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: _gameBoard[index]
                        ? Image.network(
                            'https://www.bbva.com/wp-content/uploads/2016/03/don-quijote-de-la-mancha-1920x0-c-f-1.jpg',
                            key: UniqueKey(),
                          )
                        : Image.network(
                            'https://insulabaranaria.files.wordpress.com/2012/08/imagenquijote1.jpg',
                            //key: UniqueKey(),
                          ),
                  ),
                );
              },
              itemCount: 9,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Puntuacion: $_totalHits",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _gameOver ? _startGame : null,
              child: Text(
                _gameOver ? "Volver a jugar" : "Volver a jugar",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
