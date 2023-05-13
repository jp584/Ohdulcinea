import 'package:bonfire/bonfire.dart';
import 'package:bonfire/util/talk/talk_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ohdulcinea/sprite_sheets/don_quijote_sprite_sheet.dart';
import 'package:ohdulcinea/sprite_sheets/sprite_sheets.dart';

import '../constants/animation_configs.dart';
import '../constants/globals.dart';
import '../decorations/puzzleUno.dart';
                          // NPC          TAP INTERACTION
class UglyGirlNpc extends SimpleNpc with TapGesture {

  UglyGirlNpc({required Vector2 position, required SpriteSheet spriteSheet })
      : super(position: position,
      size: Vector2(Globals.playerSize, Globals.playerSize),
      speed: 50,
      initDirection: Direction.down,
      animation:
        AnimationConfigs.uglyGirlAnimation(spriteSheet: spriteSheet) // ANIMATION BASED ON SPREED SHEET
  );

  @override
  void onTap() {
    _showDialogTalk();
  }

  // METHOD TO BUILD THE DIALOG
  void _showDialogTalk() {
    gameRef.camera.moveToTargetAnimated(this, zoom: 2, finish: () {
      TalkDialog.show(gameRef.context, [
        _speak(text: 'Hola dulcinea amor, ¿como estas?', isHero: true),
        _speak(text: 'Yo no soy dulcinea, pero, ¡puedo ser tu amor!', isHero: false),
        _speak(text: '¿Pero como es eso posible? ¡YO SOLO AMO A DULCINEA!', isHero: true),
        _speak(text: 'La última vez que vi a esa mujer, estaba dentro del castillo.\nPero la puerta esta cerrada.', isHero: false),
        _speak(text: '¡Como es eso posible!, debo encontar la Llave.', isHero: true),
        _speak(text: 'Segúro debe estar por aquí afuera.', isHero: true),
      ],
        logicalKeyboardKeysToNext: [
          LogicalKeyboardKey.space,
          LogicalKeyboardKey.enter
        ],
        onClose: () {
          gameRef.add(PuzzleUno( position: Vector2(1900,1450)));
          gameRef.camera.moveToPlayerAnimated(zoom:1);
        }
      );
    });
  }
  // DIALOGBOX BETWEEN UGLY GIRL AND QUIJOTE
  // CREATE SPEACH COMPONENT BETWEEN THE DIALOG (TEXT -> WHAT IS BEING SAYD; ISHERO -> IF THE PERSON TALKING IS THE HERO OR THE NPC)
  Say _speak({required String text, required bool isHero}) => Say(
      text: [
        TextSpan(text: text),
      ],
    person: SizedBox(
      height: Globals.dialogBox,
      width: Globals.dialogBox,
      child: isHero ? DonQuijoteSpriteSheet.spriteSheet.getSprite(0, 0).asWidget() :
      UglyGirlSpriteSheet.spriteSheet.getSprite(0, 0).asWidget(),
    ),
    personSayDirection: isHero ? PersonSayDirection.LEFT : PersonSayDirection.RIGHT
  );
}