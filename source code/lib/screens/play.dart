import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tetris_basic/size_config.dart';
import 'package:flame/game.dart';
import 'package:tetris_basic/logic/game.dart';
import 'package:tetris_basic/services/services.dart';
import 'package:provider/provider.dart';

class PlayScreen extends StatelessWidget {
  PlayScreen({super.key});

  final _singleton = Singleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.center, children: [
                  SizedBox(
                      height: SizeConfig.blockSizeVertical! * 70,
                      width: SizeConfig.blockSizeHorizontal! * 100,
                      child: null),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal! * 8 * 1.0 * 20,
                    width: SizeConfig.blockSizeHorizontal! * 8 * 1.0 * 10,
                    child: GameWidget(
                      game: TetrisApp(scale: 1.0),
                    ),
                  ),
                  Consumer<Singleton>(builder: (context, singleton, child) {
                    return (_singleton.gameOver)
                        ? Stack(alignment: Alignment.center, children: [
                            SizedBox(
                                height: SizeConfig.blockSizeVertical! * 70,
                                width: SizeConfig.blockSizeHorizontal! * 80,
                                child: null),
                            EndScreen()
                          ])
                        : Container();
                  }),
                ]),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text("SCORE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Container(
                          color: Colors.black,
                          width: SizeConfig.blockSizeHorizontal! * 29,
                          height: SizeConfig.blockSizeHorizontal! * 15,
                          child: Consumer<Singleton>(
                              builder: (context, singleton, child) {
                            return Center(
                              child: Text(singleton.currentScore.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                            );
                          }),
                        )
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal! * 2,
                    ),
                    Column(
                      children: [
                        const Text(
                          "",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Consumer<Singleton>(
                            builder: (context, singleton, child) {
                          return SizedBox(
                            width: SizeConfig.blockSizeHorizontal! * 15,
                            height: SizeConfig.blockSizeHorizontal! * 15,
                            child: TextButton(
                              onPressed: () {
                                _singleton.pauseGame();
                              },
                              child: (!_singleton.paused)
                                  ? Icon(
                                      Icons.pause,
                                      size:
                                          SizeConfig.blockSizeHorizontal! * 10,
                                      color: Colors.white,
                                    )
                                  : Icon(
                                      Icons.play_arrow,
                                      size:
                                          SizeConfig.blockSizeHorizontal! * 10,
                                      color: Colors.white,
                                    ),
                            ),
                          );
                        })
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  EndScreen({super.key});

  final _singleton = Singleton();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal! * 75,
      height: SizeConfig.blockSizeVertical! * 30,
      color: Colors.grey.shade800,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("GAMEOVER",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 60,
            height: SizeConfig.blockSizeVertical! * 7,
            child: ElevatedButton(
              onPressed: () {
                final DatabaseReference usersRef =
                    FirebaseDatabase.instance.ref().child('leaderboard');

                usersRef.update({
                  "${_singleton.currentScore}": Auth().user?.displayName
                }).then((value) => Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => route.isFirst));
              },
              child: const Text("QUIT",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25)),
            ),
          )
        ],
      ),
    );
  }
}
