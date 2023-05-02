import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/game.dart';
import '../size_config.dart';
import 'package:tetris_basic/services/singleton.dart';

class TetrisApp extends FlameGame
    with TapCallbacks, HorizontalDragDetector, VerticalDragDetector {
  final _singleton = Singleton();
  late double cellSize;

  DateTime dragStartTime = DateTime.now();
  Vector2? dragDeltaPosition;
  bool get isDragging => dragDeltaPosition != null;

  TetrisApp({double scale = 1}) {
    cellSize = SizeConfig.blockSizeHorizontal! * 8 * scale;
    _singleton.newGame();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_singleton.gameOver) return;

    _singleton.timer += dt;

    if (_singleton.timer >= _singleton.fallSpeed) {
      _singleton.timer = 0;
      _singleton.moveTetromino(0, 1);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    final touchPoint = event.canvasPosition;
    if (touchPoint.x < SizeConfig.blockSizeHorizontal! * 50) {
      rotateTetrominoCounter();
    } else {
      rotateTetromino();
    }
    HapticFeedback.lightImpact();
  }

  @override
  void onHorizontalDragStart(DragStartInfo info) {
    super.onHorizontalDragStart(info);
    dragDeltaPosition = info.eventPosition.game;
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo info) {
    super.onHorizontalDragUpdate(info);
    final delta = info.eventPosition.game - dragDeltaPosition!;
    if (delta.x / cellSize < -1) {
      _singleton.moveTetromino(-1, 0);
      dragDeltaPosition = info.eventPosition.game;
    } else if (delta.x / cellSize > 1) {
      _singleton.moveTetromino(1, 0);
      dragDeltaPosition = info.eventPosition.game;
    }
  }

  @override
  void onHorizontalDragEnd(DragEndInfo info) {
    super.onHorizontalDragEnd(info);
    dragDeltaPosition = null;
  }

  @override
  void onVerticalDragStart(DragStartInfo info) {
    super.onVerticalDragStart(info);
    dragDeltaPosition = info.eventPosition.game;
    dragStartTime = DateTime.now();
  }

  @override
  void onVerticalDragUpdate(DragUpdateInfo info) {
    if (_singleton.gameOver) return;
    super.onVerticalDragUpdate(info);
    final delta = info.eventPosition.game - dragDeltaPosition!;
    if (delta.y / cellSize > 1) {
      // handle swipe down
      _singleton.moveTetromino(0, 1);
      HapticFeedback.lightImpact();
      dragDeltaPosition = info.eventPosition.game;
    }
  }

  @override
  void onVerticalDragEnd(DragEndInfo info) {
    super.onVerticalDragEnd(info);
    dragDeltaPosition = null;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw background
    Rect bgRect = Rect.fromLTWH(0, 0, size.x + 0.2, size.y + 0.2);
    Paint bgPaint = Paint()..color = const Color.fromARGB(255, 30, 36, 41);
    canvas.drawRect(bgRect, bgPaint);

    _singleton.gameBoard.drawBoard(canvas, cellSize, "left");
    _singleton.currentTetromino.drawTetromino(canvas, cellSize, "left");
    _singleton.gameBoard
        .drawGhost(canvas, cellSize, _singleton.currentTetromino, "left");
  }

  void rotateTetromino() {
    _singleton.currentTetromino.rotate();
    if (!_singleton.gameBoard.isValidPosition(_singleton.currentTetromino)) {
      _singleton.currentTetromino.rotateCounter();
    }
  }

  void rotateTetrominoCounter() {
    _singleton.currentTetromino.rotateCounter();
    if (!_singleton.gameBoard.isValidPosition(_singleton.currentTetromino)) {
      _singleton.currentTetromino.rotate();
    }
  }
}
