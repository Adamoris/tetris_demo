import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../size_config.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final DatabaseReference _usersRef =
      FirebaseDatabase.instance.ref().child('leaderboard');

  StreamSubscription<DatabaseEvent>? _subscription;
  List<LeaderboardEntry> _placements = [];

  @override
  void initState() {
    super.initState();
    _subscription = _usersRef.onValue.listen((event) {
      final data = event.snapshot.value;
      final users = (data as Map<dynamic, dynamic>).entries.map((entry) {
        int score = int.parse(entry.key);
        String name = entry.value;
        return LeaderboardEntry(
          placement: 1,
          name: name,
          score: score,
        );
      }).toList();
      setState(() {
        _placements = List.from(users.reversed);
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("LEADERBOARD",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 240, 217, 181))),
            LeaderboardList(
              placements: _placements,
            ),
            SizedBox(
                width: 300,
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor:
                            const Color.fromARGB(255, 240, 217, 181)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/titleScreen');
                    },
                    child: const Text('Back',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 96, 59, 26)))))
          ],
        ),
      ),
    ));
  }
}

class LeaderboardList extends StatelessWidget {
  const LeaderboardList({super.key, required this.placements});
  final List<LeaderboardEntry> placements;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical! * 70,
      child: ListView.builder(
        itemCount: placements.length,
        itemBuilder: (context, index) {
          LeaderboardEntry user = placements[index];
          user.placement = index + 1;
          return user;
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LeaderboardEntry extends StatelessWidget {
  LeaderboardEntry(
      {super.key,
      required this.placement,
      required this.score,
      required this.name});
  int placement;
  final int score;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: SizeConfig.blockSizeHorizontal! * 80,
      child: Card(
          color: const Color.fromARGB(255, 240, 217, 181),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(placement.toString(), style: const TextStyle(fontSize: 25)),
              Text(name, style: const TextStyle(fontSize: 25)),
              Text('$score', style: const TextStyle(fontSize: 25)),
            ],
          )),
    );
  }
}
