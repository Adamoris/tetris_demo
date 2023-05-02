import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "routes.dart";
import "package:firebase_core/firebase_core.dart";
import '../services/singleton.dart';
import 'firebase_options.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => Singleton(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseInitialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            routes: screenRoutes,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(scaffoldBackgroundColor: Colors.grey.shade900),
          );
        }
        return Container();
      },
    );
  }
}
