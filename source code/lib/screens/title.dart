import 'package:flutter/material.dart';
import 'package:tetris_basic/size_config.dart';
import 'package:tetris_basic/services/services.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.blockSizeVertical! * 10),
          const Text("TETRIS",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 240, 217, 181))),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 75,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          const Color.fromARGB(255, 240, 217, 181)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/playScreen');
                  },
                  child: const Text('Play',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 96, 59, 26))))),
          SizedBox(height: SizeConfig.blockSizeVertical! * 3),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 75,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          const Color.fromARGB(255, 240, 217, 181)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/leaderboardScreen');
                  },
                  child: const Text('Leaderboard',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 96, 59, 26))))),
          SizedBox(height: SizeConfig.blockSizeVertical! * 10),
          SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 40,
              height: 60,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          const Color.fromARGB(255, 240, 217, 181)),
                  onPressed: () {
                    Auth().logout().then((value) {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/', (route) => false);
                    });
                  },
                  child: const Text('Logout',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 96, 59, 26))))),
          SizedBox(height: SizeConfig.blockSizeVertical),
        ],
      ),
    ));
  }
}
