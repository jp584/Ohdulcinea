
import 'package:bonfire/bonfire.dart';

import '../constants/globals.dart';

class WackUnoSpriteSheet {
  static Future<Sprite> get chestClosed => Sprite.load(
    Globals.wackChestSpriteSheet,
    srcPosition: Vector2(1,1),
    srcSize: Vector2(14,16),
  );

  static Future<Sprite> get chestOpen => Sprite.load(
    Globals.wackChestSpriteSheet,
    srcPosition: Vector2(32,1),
    srcSize: Vector2(16,16),
  );


}


