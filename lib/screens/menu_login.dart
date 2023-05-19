import 'package:flutter/material.dart';

import '../games/dulcinea_game.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/screens/login_background.jpg'),
                fit: BoxFit.fill,
            )
          ),
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Oh dulcinea',
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E - mail',
                )
              ),
              const SizedBox(height: 16.0),
              TextField(
                  controller: _nickNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Avatar',
                  )
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton( // HOW TO RETURN TO FIRST MAP
                      onPressed: () => checkId(),
                      child: const Text('Iniciar')
                  ),
                ]
              )
            ]
          )
        )
      )
    );
  }

  void checkId(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const DulcineaGame()));
  }





}
