import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_puzzle/src/ui/pages/game/controller/game_controller.dart';
import 'package:my_puzzle/src/ui/pages/game/widgets/game_buttons.dart';
import 'package:my_puzzle/src/ui/pages/game/widgets/puzzle_interactor.dart';
import 'package:my_puzzle/src/ui/pages/game/widgets/time_and_moves.dart';
import 'package:my_puzzle/src/ui/utils/time_parser.dart';
import 'package:provider/provider.dart';

class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final controller = GameController();
        controller.onFinish.listen(
          (_) {
            Timer(
              const Duration(
                milliseconds: 200,
              ),
              () {
                _showWinnerDialog(context, controller);
              },
            );
          },
        );
        return controller;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TimeAndMoves(),
              Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PuzzleInteractor(),
                ),
              ),
              GameButtons(),
            ],
          ),
        ),
      ),
    );
  }

  void _showWinnerDialog(
    BuildContext context,
    GameController controller,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("FELICIDADES GANASTE"),
            Text("moves: ${controller.state.moves}"),
            Text("time: ${parseTime(controller.time.value)}"),
            Text("Lo esencial en la construcción de un buen párrafo es la brevedad, la claridad, la precisión y la eficacia con que se expresan las ideas."),
            Text("frase conseguida: Como te quiero dulcinea"),
            const SizedBox(height: 20),
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
