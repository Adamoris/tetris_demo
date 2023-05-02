import 'package:flutter/widgets.dart';
import 'package:tetris_basic/logic/tetrominos.dart';
import 'package:tetris_basic/logic/board.dart';
import 'package:flutter/services.dart';
import 'dart:math';

class Singleton extends ChangeNotifier {
  static final Singleton _instance = Singleton._internal();

  // passes the instantiation to the _instance object
  factory Singleton() => _instance;

  //initialize variables in here
  Singleton._internal();
  var rng = Random();

  void notifyListenersSafe() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // game state variables
  bool paused = false;
  bool gameOver = false;
  late Board gameBoard;
  late Tetromino currentTetromino;
  double timer = 0;

  double fallSpeed = 0.5;

  int _currentScore = 0;
  int get currentScore => _currentScore;
  void setScore(int score) {
    _currentScore = score;
    notifyListenersSafe();
  }

  // List<int> nextTetrominoes = [];
  // List<int> reserveTetrominoes = [];

  // universal game logic functions
  void newGame() {
    gameBoard = Board(10, 20);
    timer = 0;
    paused = false;
    setScore(0);
    spawnTetromino();
    moveTetromino(0, 1);
    // initNextTetrominoes();
    gameOver = false;
    notifyListenersSafe();
  }

  void pauseGame() {
    if (gameOver) return;
    paused = !paused;
    notifyListenersSafe();
  }

  int getNextTetromino() {
    int nextTetromino = rng.nextInt(7);
    notifyListenersSafe();
    return nextTetromino;
  }

  void spawnTetromino({int shapeID = -1}) {
    int shapeIndex = getNextTetromino();

    if (shapeID != -1) {
      shapeIndex = shapeID;
    }
    List<List<int>> shape = tetrominoShapes[shapeIndex];
    int startX = (gameBoard.width / 2).floor() - (shape[0].length / 2).floor();

    currentTetromino =
        Tetromino(shape, gameBoard, shapeID: shapeIndex, x: startX, y: 0);
  }

  bool moveTetromino(int dx, int dy) {
    if (paused) return false;
    currentTetromino.x += dx;
    currentTetromino.y += dy;

    if (!gameBoard.isValidPosition(currentTetromino)) {
      currentTetromino.x -= dx;
      currentTetromino.y -= dy;

      if (dy > 0) {
        placeTetromino(currentTetromino);
        int linesCleared = gameBoard.clearLines();

        int score = currentScore;
        switch (linesCleared) {
          case 1:
            score += 40;
            break;
          case 2:
            score += 100;
            break;
          case 3:
            score += 300;
            break;
          case 4:
            score += 1200;
            break;
        }
        setScore(score);

        spawnTetromino();
        if (!gameBoard.isValidPosition(currentTetromino)) {
          // Game over
          gameOver = true;
        } else {
          moveTetromino(0, 1);
        }
      }
      return false;
    } else {
      if (dx != 0) HapticFeedback.lightImpact();
      return true;
    }
  }

  void dropTetromino() {
    if (paused || gameOver) return;
    while (moveTetromino(0, 1)) {}
  }

  void placeTetromino(Tetromino tetromino) {
    for (int y = 0; y < tetromino.shape.length; ++y) {
      for (int x = 0; x < tetromino.shape[y].length; ++x) {
        if (tetromino.shape[y][x] != 0) {
          gameBoard.matrix[tetromino.y + y][tetromino.x + x] =
              tetromino.shapeID + 1;
        }
      }
    }
    HapticFeedback.heavyImpact();
  }
}
