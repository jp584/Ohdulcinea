
import 'package:bonfire/bonfire.dart';

import 'package:ohdulcinea/constants/globals.dart';

class UglyGirlSpriteSheet {
  static Future<void> load() async {
    final image = await Flame.images.load(Globals.uglyGirlSpriteSheet);
    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 4,
      rows: 7,
    );
  }
  static late SpriteSheet spriteSheet;
}

class UglyGirlDialogImage {
  static Future<void> load() async {
    final image = await Flame.images.load(Globals.uglyGirlDialogImg);
    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 1,
      rows: 1,
    );
  }
  static late SpriteSheet spriteSheet;
}

