class Globals {
  Globals._();

  /// Time limits
  static const double spriteStepTime = 0.1;

  /// Distances
  static const int observeMaxDistance = 70;
  static const int observeMinDistance = 30;
  static const double radiusVision = 130;

  /// Sounds
  static const String gameOverSound = 'effects/game_over.wav';
  static const String powerUpSound = 'effects/power_up.wav';
  static const String successSound = 'effects/success.wav';
  static const String explosionSound = 'effects/explosion.wav';
  static const String fireSound = 'effects/fire.wav';

  // MUSIC
  static const List<String> music = ['background/1t.wav', 'background/2t.wav', 'background/3t.wav'];

  /// Sizes
  static const double itemSize = 50.0;
  static const double smallItemSize = 25.0;
  static const double defaultTileSize = 16.0;
  static const double playerSize = Globals.defaultTileSize * 1.5;
  static const double dialogBox = 100;

  /// Players
  static const String donQuijoteSpriteSheet = 'sprite_sheets/quijote.png'; // QUIJOTE SPRITE SHEET
  static const String uglyGirlSpriteSheet = 'sprite_sheets/ugly_girl.png';
  static const String blueNinjaSpriteSheet = 'sprite_sheets/blue_ninja.png';
  static const String darkNinjaSpriteSheet = 'sprite_sheets/dark_ninja.png';

  // OBJECTS
  static const String puzzleChestSpriteSheet = 'sprite_sheets/puzzle_chest.png';
  static const String wackChestSpriteSheet = 'sprite_sheets/wack_chest.png';
  static const String quizChistSpriteSheet = 'sprite_sheets/quizz_chest.png';

  // DIALOGS PICTURES
  static const String donQuijoteDialogImg = 'dialogs/donQuijote.png';
  static const String uglyGirlDialogImg = 'dialogs/uglyGirl.png';

  static const String demonCyclopIdlSpriteSheet =
      'sprite_sheets/demon_cyclop_idle.png';
  static const String demonCyclopWalkSpriteSheet =
      'sprite_sheets/demon_cyclop_walk.png';

  /// Effects
  static const String cut = 'effects/cut.png';
  static const String smoke = 'effects/smoke.png';
  static const String bigEnergyBall = 'effects/big_energy_ball.png';
  static const String circularSlash = 'effects/circular_slash.png';
  static const String fireBall = 'effects/fire_ball.png';

  /// Items
  static const String medipack = 'items/medipack.png';
  static const String shuriken = 'items/shuriken.png';
  static const String shurikenMagic = 'items/shuriken_magic.png';
  static const String sword = 'items/sword.png';
  static const String shurikenSingle = 'items/shuriken_single.png';
  static const String coin = 'items/coin.png';

  /// Decorations
  static const String fire = 'decorations/fire.png';

  // MAP
  static const String mapOne = 'map_one.json';

}