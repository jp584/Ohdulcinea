
import 'package:bonfire/bonfire.dart';

import '../constants/globals.dart';

class QuizzUnoSpriteSheet {
  static Future<Sprite> get chestClosed => Sprite.load(
    Globals.quizChistSpriteSheet,
    srcPosition: Vector2(16,1),
    srcSize: Vector2(16,27),
  );

  static Future<Sprite> get chestOpen => Sprite.load(
    Globals.quizChistSpriteSheet,
    srcPosition: Vector2(1,1),
    srcSize: Vector2(16,27),
  );


}


