import 'package:flutter/material.dart';
import 'package:ohdulcinea/games/dulcinea_game.dart';
import 'package:ohdulcinea/sprite_sheets/don_quijote_sprite_sheet.dart';
import 'package:ohdulcinea/sprite_sheets/sprite_sheets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DonQuijoteSpriteSheet.load();
  await UglyGirlSpriteSheet.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DulcineaGame(),
    );
  }
}


