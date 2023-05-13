import 'package:bonfire/bonfire.dart';
import 'package:flame_audio/flame_audio.dart';

import '../constants/globals.dart';
import '../miniGames/puzzle_easy.dart';
import '../players/don_quijote.dart';


// OBJECTS INHERIT OF GAME DECORATION WITH PLAYER
class PuzzleUno extends GameDecoration with Sensor<DonQuijotePlayer>{

  final double _life = 25; // MEDIPACK WILL GIVE LIFE TO OUR PLAYER

  PuzzleUno({required Vector2 position}) : // CONSTRUCTURE (SPRITE; POSITION; SIZE)
        super.withSprite(
          sprite: Sprite.load(Globals.medipack), // SPRITE OF THE OBJECT
          position: position, // POSITION OF THE ITEM
          size: Vector2.all(Globals.smallItemSize,) // ITEM SIZE
      );

  // WHAT WILL HAPPEN WHEN THE PLAYER CONTACT THE MEDIPACK
  @override
  void onContact(GameComponent component) {
    FlameAudio.play(Globals.powerUpSound);
    // SOUND THAT WILL PLAY
    removeFromParent(); // WILL REMOVE THE OBJECT FROM THE VIEW
    //gameRef.player!.addLife(_life); // ACTION
    gameRef.pauseEngine();
    gameRef.overlayManager.add(PuzzleEasy.id);


  }

}