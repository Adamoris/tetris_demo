import 'package:flutter/material.dart';
import 'board.dart';
import '../size_config.dart';

class Tetromino {
  List<List<int>> shape;
  Board board;
  int shapeID;
  int x;
  int y;

  Tetromino(this.shape, this.board, {this.shapeID = 0, this.x = 0, this.y = 0});

  void rotate() {
    shape = rotateMatrixClockwise(shape);
  }

  void rotateCounter() {
    shape = rotateMatrixCounterClockwise(shape);
  }

  void drawTetromino(Canvas canvas, double cellSize, String alignment) {
    Paint cellPaint = Paint();
    int offsetX = 0;
    int offsetY = 0;

    switch (alignment) {
      case "center":
        offsetX = (SizeConfig.blockSizeHorizontal! *
                ((100 -
                        ((cellSize / SizeConfig.blockSizeHorizontal!) *
                            board.width)) /
                    2))
            .round();
        offsetY = -cellSize.round() * 2;
        break;
      case "left":
        offsetX = 0;
        offsetY = -cellSize.round() * 2;
        break;
      case "right":
        offsetX = 8;
        offsetY = -cellSize.round() * 2;
        break;
      default:
        offsetX = 4;
        offsetY = -cellSize.round() * 2;
        break;
    }

    for (int y = 0; y < shape.length; ++y) {
      for (int x = 0; x < shape[y].length; ++x) {
        if (shape[y][x] != 0 && this.y + y >= 2) {
          cellPaint.color = tetrominoColors[shapeID];
          canvas.drawRect(
            Rect.fromLTWH(
              (this.x + x) * cellSize + offsetX,
              (this.y + y) * cellSize + offsetY,
              cellSize,
              cellSize,
            ),
            cellPaint,
          );
        }
      }
    }
  }
}

const List<List<List<int>>> tetrominoShapes = [
  [
    // I
    [0, 0, 0, 0],
    [1, 1, 1, 1],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ],
  [
    // O
    [1, 1],
    [1, 1],
  ],
  [
    // T
    [0, 1, 0],
    [1, 1, 1],
    [0, 0, 0],
  ],
  [
    // L
    [0, 0, 1],
    [1, 1, 1],
    [0, 0, 0],
  ],
  [
    // J
    [1, 0, 0],
    [1, 1, 1],
    [0, 0, 0],
  ],
  [
    // S
    [0, 1, 1],
    [1, 1, 0],
    [0, 0, 0],
  ],
  [
    // Z
    [1, 1, 0],
    [0, 1, 1],
    [0, 0, 0],
  ],
];

final List<Color> tetrominoColors = [
  Colors.cyan, // I
  Colors.yellow, // O
  Colors.purple, // T
  Colors.orange, // L
  Colors.blue, // J
  Colors.green, // S
  Colors.red, // Z
];

List<List<int>> rotateMatrixClockwise(List<List<int>> matrix) {
  int rows = matrix.length;
  int cols = matrix[0].length;
  List<List<int>> result = List.generate(cols, (_) => List.filled(rows, 0));

  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      result[j][rows - i - 1] = matrix[i][j];
    }
  }

  return result;
}

List<List<int>> rotateMatrixCounterClockwise(List<List<int>> matrix) {
  int rows = matrix.length;
  int cols = matrix[0].length;
  List<List<int>> result = List.generate(cols, (_) => List.filled(rows, 0));

  for (int i = 0; i < rows; ++i) {
    for (int j = 0; j < cols; ++j) {
      result[cols - j - 1][i] = matrix[i][j];
    }
  }

  return result;
}
