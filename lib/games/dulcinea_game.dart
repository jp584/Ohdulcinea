import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

import 'package:ohdulcinea/npc/ugly_girl_npc.dart';

import '../constants/globals.dart';
import '../players/don_quijote.dart';
import 'package:ohdulcinea/sprite_sheets/sprite_sheets.dart';


class  DulcineaGame extends StatefulWidget {
  const DulcineaGame ({Key? key}) : super(key: key);

  @override
  State<DulcineaGame> createState() => _DulcineaGameState();
}

class _DulcineaGameState extends State<DulcineaGame> {
  @override
  Widget build(BuildContext context) {

    return BonfireWidget(
        player:DonQuijotePlayer(position: Vector2(800,800),
            spriteSheet: DonQuijoteSpriteSheet.spriteSheet),
        joystick: Joystick(
          directional: JoystickDirectional(),
        ),
        map: WorldMapByTiled(
          Globals.mapOne,// MAP DIRECTION
          forceTileSize: Vector2(32, 32),
          objectsBuilder: { // WE MAP THE NPC TROUGH THIS OBJECT BUILDER
            'ugly_girl': (properties) =>
                UglyGirlNpc(position: properties.position,
                    spriteSheet: UglyGirlSpriteSheet.spriteSheet)
          }
      ),
    );
  }
}
