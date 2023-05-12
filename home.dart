import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class WhackAMoleGame extends StatefulWidget {
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
    _timer?.cancel();
  }

  void _startGame() {
    _gameBoard = List.filled(9, false);
    _totalMoles = 0;
    _totalHits = 0;
    _gameOver = false;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
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
      Future.delayed(Duration(seconds: 2), () {
        if (!_gameOver) {
          setState(() {
            _gameBoard[index] = false;
          });
        }
      });
    });
  }

  void _hitMole(int index) {
    setState(() {
      _gameBoard[index] = false;
      _totalHits++;

      if (_totalHits >= 10) {
        _endGame();
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whack-a-Mole"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: _gameBoard[index] ? Colors.red : Colors.black,
                    minimumSize: Size(80, 80),
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
              },
              itemCount: 9,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Golpes totales: $_totalHits",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _gameOver ? _startGame : null,
              child: Text(
                _gameOver ? "Play Again" : "Start Game",
                style: TextStyle(
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