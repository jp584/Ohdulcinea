
import 'package:bonfire/bonfire.dart';

import '../constants/globals.dart';

class PuzzleUnoSpriteSheet {
  static Future<Sprite> get chestClosed => Sprite.load(
  Globals.puzzleChestSpriteSheet,
  srcPosition: Vector2(1,1),
  srcSize: Vector2(14,16),
  );

  static Future<Sprite> get chestOpen => Sprite.load(
    Globals.puzzleChestSpriteSheet,
    srcPosition: Vector2(48,1),
    srcSize: Vector2(14,16),
  );


  }


