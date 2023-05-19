import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;





String parseTime(int time) {
  final duration = Duration(
    seconds: time,
  );

  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');

  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

  return "$minutes:$seconds";
}

class puzzleEasy extends StatelessWidget {
  const puzzleEasy({Key? key}) : super(key: key);

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
        appBar: AppBar(
          title: Text('Rompe Cabezas'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
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
class GameController extends ChangeNotifier {
  GameState _state = GameState(
    crossAxisCount: 3,
    puzzle: Puzzle.create(3),
    solved: false,
    moves: 0,
    status: GameStatus.created,
  );

  final ValueNotifier<int> time = ValueNotifier(0);

  final StreamController<void> _streamController = StreamController.broadcast();

  Stream<void> get onFinish => _streamController.stream;

  Timer? _timer;

  GameState get state => _state;

  Puzzle get puzzle => _state.puzzle;

  void onTileTapped(Tile tile) {
    final canMove = puzzle.canMove(tile.position);
    if (canMove) {
      final newPuzzle = puzzle.move(tile);
      final solved = newPuzzle.isSolved();
      _state = state.copyWith(
        puzzle: newPuzzle,
        moves: state.moves + 1,
        status: solved ? GameStatus.solved : state.status,
      );
      notifyListeners();
      if (solved) {
        _timer?.cancel();
        _streamController.sink.add(null);
      }
    }
  }

  void shuffle() {
    if (_timer != null) {
      time.value = 0;
      _timer!.cancel();
    }
    _state = state.copyWith(
      puzzle: puzzle.shuffle(),
      status: GameStatus.playing,
      moves: 0,
    );
    notifyListeners();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        time.value++;
      },
    );
  }

  void changeGrid(int crossAxisCount) {
    _timer?.cancel();
    time.value = 0;
    final newState = GameState(
      crossAxisCount: crossAxisCount,
      puzzle: Puzzle.create(crossAxisCount),
      solved: false,
      moves: 0,
      status: GameStatus.created,
    );
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose() {
    _streamController.close();
    _timer?.cancel();
    super.dispose();
  }
}

class GameButtons extends StatelessWidget {
  const GameButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();
    final state = controller.state;
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
            onPressed: controller.shuffle,
            icon: const Icon(
              Icons.replay_rounded,
            ),
            label: Text(
              state.status == GameStatus.created ? "START" : "RESET",
            ),
          ),
          const SizedBox(width: 20),
          DropdownButton<int>(
            items: [3, 4, 5, 6]
                .map(
                  (e) => DropdownMenuItem(
                child: Text("${e}x$e"),
                value: e,
              ),
            )
                .toList(),
            onChanged: (crossAxisCount) {
              if (crossAxisCount != null && crossAxisCount != state.crossAxisCount) {
                controller.changeGrid(crossAxisCount);
              }
            },
            value: state.crossAxisCount,
          ),
        ],
      ),
    );
  }
}

class PuzzleInteractor extends StatelessWidget {
  const PuzzleInteractor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final controller = context.watch<GameController>();
          final state = controller.state;
          final tileSize = constraints.maxWidth / state.crossAxisCount;

          return AbsorbPointer(
            absorbing: state.status != GameStatus.playing,
            child: Stack(
              children: state.puzzle.tiles
                  .map(
                    (e) => PuzzleTile(
                  tile: e,
                  size: tileSize,
                  onTap: () => controller.onTileTapped(e),
                ),
              )
                  .toList(),
            ),
          );
        },
      ),
    );
  }
}

class PuzzleTile extends StatelessWidget {
  final Tile tile;
  final double size;
  final VoidCallback onTap;
  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.size,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(
        milliseconds: 200,
      ),
      left: (tile.position.x - 1) * size,
      top: (tile.position.y - 1) * size,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.all(1),
          width: size - 2,
          height: size - 2,
          alignment: Alignment.center,
          child: Text(
            tile.value.toString(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class TimeAndMoves extends StatelessWidget {
  const TimeAndMoves({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final time = Provider.of<GameController>(context, listen: false).time;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ValueListenableBuilder<int>(
          valueListenable: time,
          builder: (_, time, icon) {
            return Row(
              children: [
                icon!,
                Text(
                  parseTime(time),
                ),
              ],
            );
          },
          child: const Icon(
            Icons.watch,
          ),
        ),
        Selector<GameController, int>(
          builder: (_, moves, __) {
            return Text("Moves: $moves");
          },
          selector: (_, controller) => controller.state.moves,
        ),
      ],
    );
  }
}

enum GameStatus {
  created,
  playing,
  solved,
}

class GameState extends Equatable {
  final int crossAxisCount;
  final Puzzle puzzle;
  final bool solved;
  final int moves;
  final GameStatus status;

  const GameState({
    required this.crossAxisCount,
    required this.puzzle,
    required this.solved,
    required this.moves,
    required this.status,
  });

  GameState copyWith({
    int? crossAxisCount,
    int? moves,
    Puzzle? puzzle,
    bool? solved,
    GameStatus? status,
  }) {
    return GameState(
      status: status ?? this.status,
      moves: moves ?? this.moves,
      crossAxisCount: crossAxisCount ?? this.crossAxisCount,
      puzzle: puzzle ?? this.puzzle,
      solved: solved ?? this.solved,
    );
  }

  @override
  List<Object?> get props => [
    moves,
    crossAxisCount,
    puzzle,
    solved,
    status,
  ];
}

class Tile extends Equatable {
  final int value;
  final Position position;
  final Position correctPosition;

  const Tile({
    required this.value,
    required this.position,
    required this.correctPosition,
  });

  Tile move(Position newPosition) {
    return Tile(
      value: value,
      correctPosition: correctPosition,
      position: newPosition,
    );
  }

  @override
  List<Object?> get props => [
    position,
    correctPosition,
    value,
  ];
}

class Position extends Equatable {
  final int x; // column
  final int y; // row

  const Position({
    required this.x,
    required this.y,
  });

  @override
  List<Object?> get props => [x, y];
}

class Puzzle extends Equatable {
  final List<Tile> tiles;

  final Position emptyPosition;

  const Puzzle._({
    required this.tiles,
    required this.emptyPosition,
  });

  /// a tile can be moved if is in the same
  /// row or in the same column of emptyPosition
  bool canMove(Position tilePosition) {
    if (tilePosition.x == emptyPosition.x || tilePosition.y == emptyPosition.y) {
      return true;
    }
    return false;
  }

  /// moves one or more tile vertically or horizontally
  Puzzle move(Tile tile) {
    final copy = [...tiles];
    // left or right
    if (tile.position.y == emptyPosition.y) {
      final row = tiles.where(
            (e) => e.position.y == emptyPosition.y,
      );

      // right
      if (tile.position.x < emptyPosition.x) {
        for (final e in row) {
          if (e.position.x < tile.position.x || e.position.x > emptyPosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x + 1,
              y: e.position.y,
            ),
          );
        }
      } else {
        // left
        for (final e in row) {
          if (e.position.x > tile.position.x || e.position.x < emptyPosition.x) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x - 1,
              y: e.position.y,
            ),
          );
        }
      }
    } else {
      // top or bottom
      final column = tiles.where(
            (e) => e.position.x == emptyPosition.x,
      );

      // bottom
      if (tile.position.y < emptyPosition.y) {
        for (final e in column) {
          if (e.position.y > emptyPosition.y || e.position.y < tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y + 1,
            ),
          );
        }
      } else {
        // top
        for (final e in column) {
          if (e.position.y < emptyPosition.y || e.position.y > tile.position.y) {
            continue;
          }
          copy[e.value - 1] = e.move(
            Position(
              x: e.position.x,
              y: e.position.y - 1,
            ),
          );
        }
      }
    }
    return Puzzle._(
      tiles: copy,
      emptyPosition: tile.position,
    );
  }

  /// creates a sorted puzzle
  factory Puzzle.create(int crossAxisCount) {
    int value = 1;
    final tiles = <Tile>[];

    final emptyPosition = Position(
      x: crossAxisCount,
      y: crossAxisCount,
    );
    for (int y = 1; y <= crossAxisCount; y++) {
      for (int x = 1; x <= crossAxisCount; x++) {
        final add = !(x == crossAxisCount && y == crossAxisCount);
        if (add) {
          final position = Position(x: x, y: y);
          final tile = Tile(
            value: value,
            position: position,
            correctPosition: position,
          );
          tiles.add(tile);
          value++;
        }
      }
    }

    return Puzzle._(
      tiles: tiles,
      emptyPosition: emptyPosition,
    );
  }

  /// shuffle the puzzle tiles
  Puzzle shuffle() {
    final values = List.generate(
      tiles.length,
          (index) => index + 1,
    );
    values.add(0);
    values.shuffle();

    // [1,2,3,4,5,6,7,8,9,0] => [1,3,4,0,5,7,8,9,2,6]

    if (_isSolvable(values)) {
      int x = 1, y = 1;
      late Position emptyPosition;
      final copy = [...tiles];
      final int crossAxisCount = math.sqrt(values.length).toInt();

      for (int i = 0; i < values.length; i++) {
        final value = values[i];
        final position = Position(x: x, y: y);
        if (value == 0) {
          emptyPosition = position;
        } else {
          copy[value - 1] = copy[value - 1].move(
            position,
          );
        }

        if ((i + 1) % crossAxisCount == 0) {
          y++;
          x = 1;
        } else {
          x++;
        }
      }

      return Puzzle._(
        tiles: copy,
        emptyPosition: emptyPosition,
      );
    } else {
      return shuffle();
    }
  }

  bool _isSolvable(List<int> values) {
    final n = math.sqrt(values.length);

    /// inversions
    int inversions = 0;
    int y = 1;
    int emptyPositionY = 1;

    for (int i = 0; i < values.length; i++) {
      if (i > 0 && i % n == 0) {
        y++;
      }

      final current = values[i];
      if (current == 1 || current == 0) {
        if (current == 0) {
          emptyPositionY = y;
        }
        continue;
      }
      for (int j = i + 1; j < values.length; j++) {
        final next = values[j];

        if (current > next && next != 0) {
          inversions++;
        }
      }
    }

    // is odd
    if (n % 2 != 0) {
      return inversions % 2 == 0;
    } else {
      // is even

      final yFromBottom = n - emptyPositionY + 1;

      if (yFromBottom % 2 == 0) {
        return inversions % 2 != 0;
      } else {
        return inversions % 2 == 0;
      }
    }
  }

  bool isSolved() {
    final crossAxisCount = math.sqrt(tiles.length + 1).toInt();
    if (emptyPosition.x == crossAxisCount && emptyPosition.y == crossAxisCount) {
      for (final tile in tiles) {
        if (tile.position != tile.correctPosition) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [
    tiles,
    emptyPosition,
  ];
}



