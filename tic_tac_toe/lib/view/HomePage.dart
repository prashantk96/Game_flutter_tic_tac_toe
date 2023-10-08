import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tic_tac_toe/view/GamePage.dart';

import 'Ai.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final playerController1 = TextEditingController();
  final playerController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 300),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    controller: playerController1,
                    decoration: const InputDecoration(
                      hintText: 'Player1',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    maxLength: 10,
                    controller: playerController2,
                    decoration: const InputDecoration(
                      hintText: 'Player2',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (playerController1.text.isNotEmpty &&
                          playerController2.text.isNotEmpty) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return GamePage(
                            player1: playerController1.text,
                            player2: playerController2.text,
                          );
                        }));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'please enter both player names');
                      }
                    },
                    child: const Text('Continue')),
                ElevatedButton(
                    onPressed: () {
                      if (playerController1.text.isNotEmpty &&
                          playerController2.text.isNotEmpty) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Ai(
                            player1: playerController1.text,
                            player2: playerController2.text,
                          );
                        }));
                      } else {
                        Fluttertoast.showToast(
                            msg: 'please enter both player names');
                      }
                    },
                    child: const Text('Play with Computer')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
