
import 'package:bonfire/bonfire.dart';

import 'package:ohdulcinea/constants/globals.dart';

class DonQuijoteSpriteSheet {
  static Future<void> load() async {
    final image = await Flame.images.load(Globals.donQuijoteSpriteSheet);
    spriteSheet = SpriteSheet.fromColumnsAndRows(
      image: image,
      columns: 4,
      rows: 7,
    );
  }

  static late SpriteSheet spriteSheet;
}