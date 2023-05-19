import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/globals.dart';
import '../controller/dulcineaController.dart';
import '../miniGames/puzzle_easy.dart';
import '../miniGames/whack_easy.dart';
import '../players/don_quijote.dart';
import '../sprite_sheets/wack_sprite_sheet.dart';

// OBJECTS INHERIT OF GAME DECORATION WITH PLAYER
class WackUno extends GameDecoration
    with Sensor<DonQuijotePlayer>, ObjectCollision, TapGesture {
  final QuijoteController quijoCtrl = Get.find<QuijoteController>();

  bool _isClosed = false;

  Sprite? chestClosed, chestOpen;

  WackUno({required Vector2 position})
      : // CONSTRUCTURE (SPRITE; POSITION; SIZE)
        super.withSprite(
            //sprite: Sprite.load(Globals.puzzleChestSpriteSheet), // SPRITE OF THE OBJECT
            sprite: WackUnoSpriteSheet.chestClosed, // SPRITE OF THE OBJECT
            position: position, // POSITION OF THE ITEM
            size: Vector2.all(
              Globals.smallItemSize,
            ) // ITEM SIZE
            ) {
    setupCollision(
      CollisionConfig(
          collisions: [CollisionArea.rectangle(size: Vector2(10, 10))]),
    );
  }

  // WHAT THE CHEST WILL DO WHEN QUIJOTE BUMPS TO IT
  @override
  void update(double dt) {
    seeComponentType<DonQuijotePlayer>(
        observed: (player) {
          // IF THE GAME WASN'T COMPLETED YET
          if (!_isClosed) {
            _isClosed = true;
            //_showDialog();
          }
        },
        notObserved: () {
          _isClosed = false;
        },
        radiusVision: Globals.defaultTileSize * 2);
    super.update(dt);
  }

  // CHANGE SPRITE WHEN THE CHEST IS NEAR QUIJOTE
  @override
  void render(Canvas canvas) {
    if (_isClosed) {
      sprite = chestOpen;
    } else {
      sprite = chestClosed;
    }
    super.render(canvas);
  }

  // LOAD SPRITES ASYNC
  @override
  Future<void> onLoad() async {
    chestOpen = await WackUnoSpriteSheet.chestOpen;
    chestClosed = await WackUnoSpriteSheet.chestClosed;
    return super.onLoad();
  }

  // MINI GAME LOAD METHOD
  void _showDialog() {
    showDialog(
        context: context,
        builder: (_) {
          if (!quijoCtrl.rompeUno.value) {
            return const WhackAMoleGameEasy();
          } else {
            return AlertDialog(
                content: Text('Ya ganaste este juego'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Ok')),
                ]);
          }
        });
  }

  @override
  void onTap() {
    if (_isClosed) {
      _showDialog();
    }
  }

  @override
  void onContact(GameComponent component) {
    // TODO: implement onContact
  }

// WHAT WILL HAPPEN WHEN THE PLAYER CONTACT THE CHEST
// @override
// void onContact(GameComponent component) {
//   FlameAudio.play(Globals.powerUpSound);
//   // SOUND THAT WILL PLAY
//   removeFromParent(); // WILL REMOVE THE OBJECT FROM THE VIEW
//   //gameRef.player!.addLife(_life); // ACTION
//   quijoCtrl.changeCoordinateX(component.position.x);
//   quijoCtrl.changeCoordinateY(component.position.y);
//   Vector2 xd = Vector2(component.position.x, component.position.y);
//
//
//   gameRef.pauseEngine();
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const PuzzleEasy()));
//   // gameRef.overlayManager.add(PuzzleEasy.id);
// }
}
