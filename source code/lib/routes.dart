import 'auth_checker.dart';
import 'package:tetris_basic/screens/login.dart';
import 'package:tetris_basic/screens/register.dart';
import 'package:tetris_basic/screens/title.dart';
import 'package:tetris_basic/screens/leaderboard.dart';
import 'package:tetris_basic/screens/play.dart';

var screenRoutes = {
  '/': (context) => const AuthChecker(),
  '/loginScreen': (context) => const LoginScreen(),
  '/registerScreen': (context) => const RegisterScreen(),
  '/titleScreen': (context) => const TitleScreen(),
  '/leaderboardScreen': (context) => const LeaderboardScreen(),
  '/playScreen': (context) => PlayScreen(),
};
