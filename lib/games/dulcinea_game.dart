import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ohdulcinea/controller/dulcineaController.dart';

import 'package:ohdulcinea/npc/ugly_girl_npc.dart';

import '../constants/globals.dart';
import '../decorations/puzzleUno.dart';
import '../decorations/quizzUno.dart';
import '../decorations/wackUno.dart';
import '../enums/map_id.dart';
import '../miniGames/puzzle_easy.dart';
import '../players/don_quijote.dart';
import 'package:ohdulcinea/sprite_sheets/sprite_sheets.dart';

MapId currentMapId = MapId.one; // ENUMS TO IDENTIFY MAPS BY ID

late Function(MapId) selectMap; // LATE FUNCTION TO SELECT A MAP

class  DulcineaGame extends StatefulWidget {
  const DulcineaGame ({Key? key}) : super(key: key);
  @override
  State<DulcineaGame> createState() => _DulcineaGameState();

}


class _DulcineaGameState extends State<DulcineaGame> {


  // OVERRIDE DISPOSE METHOD FOR MAP ROUTING
  @override
  void dispose(){

    currentMapId = MapId.one;
    super.dispose();
  }


  @override
  void initState(){

    selectMap = (MapId id){ // LATE SELECT FUNCTION THAT WILL TAKE A MAP ID AND FROM THERE WILL REBUILD THE ENTIRE WIDGET WITH THE CURRENT MAP ID
      setState(() {
      currentMapId = id;
      });
    };
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    Random random = Random();
    // FlameAudio.bgm.initialize();
    // FlameAudio.bgm.play(Globals.music[random.nextInt(3)]);
    final QuijoteController quijoCtrl = Get.find<QuijoteController>();

    switch(currentMapId){ // MAPPING ID ROUTING
      case MapId.one:

      case MapId.two:
      case MapId.three:

       default:
      return Obx(() => BonfireWidget(
        key: Key(DateTime.now().toIso8601String()), // THIS KEY NEEDS TO BE IN EVERY BONEFIREWIDGET
        overlayBuilderMap: { // MINI MAP
          PuzzleEasy.id: (context, game) => const PuzzleEasy(),
          'mini_map':(context, game) => MiniMap(
              game: game,
              margin: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withOpacity(0)))
        },
        initialActiveOverlays:const <String>['mini_map'],


        player:DonQuijotePlayer(position: Vector2(quijoCtrl.cordinateX.value,quijoCtrl.cordinateY.value),
            spriteSheet: DonQuijoteSpriteSheet.spriteSheet),
        // showCollisionArea: true,
        joystick: Joystick(
          directional: JoystickDirectional(),
        ),
        map: WorldMapByTiled(
            Globals.mapOne,// MAP DIRECTION
            forceTileSize: Vector2(32, 32),
            objectsBuilder: { // WE MAP THE NPC TROUGH THIS OBJECT BUILDER
              'ugly_girl': (properties) =>
                  UglyGirlNpc(position: properties.position,
                      spriteSheet: UglyGirlSpriteSheet.spriteSheet),
              'puzzleOne': (properties) => PuzzleUno( position: properties.position),
              'wackOne': (properties) => WackUno( position: properties.position),
              'quizzOne': (properties) => QuizzUno( position: properties.position),
            }
        ),
      )
      );

    }
  }
}
