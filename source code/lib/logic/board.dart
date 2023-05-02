import 'tetrominos.dart';
import 'package:flutter/material.dart';
import 'package:tetris_basic/size_config.dart';

class Board {
  int width;
  int height;
  int hiddenRows = 2;
  late List<List<int>> matrix;

  Board(this.width, this.height, {this.hiddenRows = 2}) {
    height += hiddenRows;
    matrix = List.generate(height, (_) => List.filled(width, 0));
  }

  bool isValidPosition(Tetromino tetromino) {
    for (int y = 0; y < tetromino.shape.length; ++y) {
      for (int x = 0; x < tetromino.shape[y].length; ++x) {
        if (tetromino.shape[y][x] == 0) continue;

        int boardX = tetromino.x + x;
        int boardY = tetromino.y + y;

        if (boardX < 0 || boardX >= width || boardY < 0 || boardY >= height) {
          return false;
        }

        if (matrix[boardY][boardX] != 0) {
          return false;
        }
      }
    }
    return true;
  }

  int clearLines() {
    int linesCleared = 0;

    for (int y = 0; y < height; ++y) {
      bool lineCompleted = true;

      for (int x = 0; x < width; ++x) {
        if (matrix[y][x] == 0) {
          lineCompleted = false;
          break;
        }
      }

      if (lineCompleted) {
        linesCleared++;
        matrix.removeAt(y);
        matrix.insert(0, List.filled(width, 0));
      }
    }

    return linesCleared;
  }

  void drawBoard(Canvas canvas, double cellSize, String alignment) {
    Paint cellPaint = Paint();
    int offsetX = 0;
    int offsetY = 0;

    switch (alignment) {
      case "center":
        offsetX = (SizeConfig.blockSizeHorizontal! *
                ((100 -
                        ((cellSize / SizeConfig.blockSizeHorizontal!) *
                            width)) /
                    2))
            .round();
        offsetY = -cellSize.round() * 2;
        break;
      case "left":
        offsetX = 0;
        offsetY = -cellSize.round() * 2;
        break;
      case "right":
        offsetX = width - matrix[0].length;
        offsetY = -cellSize.round() * 2;
        break;
    }

    // Draw the game board
    for (int y = 0; y < height; ++y) {
      for (int x = 0; x < width; ++x) {
        if (y > hiddenRows - 1) {
          if (matrix[y][x] != 0) {
            cellPaint.color = tetrominoColors[matrix[y][x] - 1];

            canvas.drawRect(
              Rect.fromLTWH(
                x * cellSize + offsetX,
                y * cellSize + offsetY,
                cellSize,
                cellSize,
              ),
              cellPaint,
            );
          } else {
            cellPaint.color = const Color.fromARGB(255, 0, 0, 0);
            canvas.drawRect(
              Rect.fromLTWH(x * cellSize + offsetX, y * cellSize + offsetY,
                  cellSize, cellSize),
              cellPaint,
            );
          }
        }
      }
    }
  }

  void drawGhost(
      Canvas canvas, double cellSize, Tetromino tetromino, String alignment) {
    int offsetX = 0;
    int offsetY = 0;

    switch (alignment) {
      case "center":
        offsetX = (SizeConfig.blockSizeHorizontal! *
                ((100 -
                        ((cellSize / SizeConfig.blockSizeHorizontal!) *
                            width)) /
                    2))
            .round();
        offsetY = -cellSize.round() * 2;
        break;
      case "left":
        offsetX = 0;
        offsetY = -cellSize.round() * 2;
        break;
      case "right":
        offsetX = width - matrix[0].length;
        offsetY = -cellSize.round() * 2;
        break;
    }

    Paint cellPaint = Paint();
    cellPaint.color = const Color.fromARGB(100, 255, 255, 255);
    int ghostY = tetromino.y;
    while (isValidPosition(Tetromino(tetromino.shape, this,
        shapeID: tetromino.shapeID, x: tetromino.x, y: ghostY + 1))) {
      ghostY++;
    }

    for (int y = 0; y < tetromino.shape.length; ++y) {
      for (int x = 0; x < tetromino.shape[y].length; ++x) {
        if (tetromino.shape[y][x] != 0 && y + ghostY > hiddenRows - 1) {
          canvas.drawRect(
            Rect.fromLTWH(
              (tetromino.x + x) * cellSize + offsetX,
              (ghostY + y) * cellSize + offsetY,
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
