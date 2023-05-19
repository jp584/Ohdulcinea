import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:ohdulcinea/controller/dulcineaBinding.dart';
import 'package:ohdulcinea/screens/menu_login.dart';
import 'package:ohdulcinea/sprite_sheets/don_quijote_sprite_sheet.dart';
import 'package:ohdulcinea/sprite_sheets/sprite_sheets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DonQuijoteSpriteSheet.load();
  await DonQuijoteDialogImage.load();
  await UglyGirlSpriteSheet.load();
  await UglyGirlDialogImage.load();

  // await PuzzleUnoClosedSpriteSheet.load();
  // await PuzzleUnoOpenSpriteSheet.load();
  //FlameAudio.bgm.stop();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Oh Dulcinea',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: QuijoteBinding(),
      home: Menu(),
      //DulcineaGame(),
    );
  }
}
