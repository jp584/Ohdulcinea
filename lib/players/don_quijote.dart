import 'package:bonfire/bonfire.dart';

import 'package:ohdulcinea/constants/animation_configs.dart';
import 'package:ohdulcinea/constants/globals.dart';

class DonQuijotePlayer extends SimplePlayer{

  DonQuijotePlayer({required Vector2 position, required SpriteSheet spriteSheet })
  : super(position: position,
  size: Vector2(Globals.playerSize, Globals.playerSize),
    speed: 100,
    life: 100,
    initDirection: Direction.up,
    animation: AnimationConfigs.guijoteAnimation(spriteSheet: spriteSheet) // ANIMATION BASED ON SPREED SHEET
  );
}