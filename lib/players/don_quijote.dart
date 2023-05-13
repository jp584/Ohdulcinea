import 'package:bonfire/bonfire.dart';

import 'package:ohdulcinea/constants/animation_configs.dart';
import 'package:ohdulcinea/constants/globals.dart';

import '../decorations/puzzleUno.dart';

class DonQuijotePlayer extends SimplePlayer with ObjectCollision {

  DonQuijotePlayer({required Vector2 position, required SpriteSheet spriteSheet })
  : super(position: position,
  size: Vector2(Globals.playerSize, Globals.playerSize),
    speed: 100,
    life: 100,
    initDirection: Direction.up,
    animation: AnimationConfigs.guijoteAnimation(spriteSheet: spriteSheet) // ANIMATION BASED ON SPREED SHEET
  ) {

    setupCollision( // COLLISION SETTER
        CollisionConfig(
          collisions: [
          CollisionArea.rectangle(
        size: Vector2(24, 24),
          ),
        ],
    ));
  
  }
}