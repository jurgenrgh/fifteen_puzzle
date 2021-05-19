import 'package:flutter/material.dart';
import 'puzzle_globals.dart' as globals;
import 'puzzle_functions.dart';
import 'dart:math';

class Board {
  static final tiles = List.generate(
      globals.maxRows,
      (i) => List.generate(globals.maxCols, (j) => i * globals.maxCols + j + 1,
          growable: false),
      growable: false);

  static initTiles(int rows, int cols) {
    if (!globals.shuffleFlag) {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          tiles[i][j] = i * cols + j + 1;
        }
      }
    }
    globals.shuffleFlag = false;
  }

  static int getRandomIx(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  static shuffle(int rows, int cols) {
    //print("shuffle routine $rows, $cols");
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        int i = getRandomIx(rows);
        int j = getRandomIx(cols);
        int tem = tiles[i][j];
        tiles[i][j] = tiles[row][col];
        tiles[row][col] = tem;
      }
    }
  }
}

class ShuffleButton extends StatelessWidget {
  final Function doShuffle;
  ShuffleButton({this.doShuffle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        doShuffle();
      },
      child: Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.amber[500],
        ),
        child: Center(
          child:
              Text('Shuffle', style: TextStyle(fontSize: globals.tileSize / 4)),
        ),
      ),
    );
  }
}

class TapTile extends StatefulWidget {
  final int id;
  int x;
  int y;
  TapTile({this.id, this.x, this.y});

  @override
  _TapTileState createState() => _TapTileState();
}

class _TapTileState extends State<TapTile> {
  var totalTiles = globals.nbrRows * globals.nbrColumns;

  @override
  Widget build(BuildContext context) {
    Color color = globals.tileColors[getTileColor(
      Board.tiles[widget.x][widget.y],
      widget.x,
      widget.y,
    )];

    int id = Board.tiles[widget.x][widget.y];
    //bool isLast = detectLastTile(id, nbrRows, nbrColumns);
    //double tileSize = getTileSize(context, nbrRows, nbrColumns);
    return GestureDetector(
      onTap: () {
        print(id.toString() + ' was tapped!');
        if (((widget.y + 1) < globals.nbrColumns) &&
            (Board.tiles[widget.x][widget.y + 1] ==
                globals.nbrRows * globals.nbrColumns)) {
          print(id.toString() + ' can move right');
        } else {
          print(id.toString() + ' cannot move right');
        }
        if ((widget.y > 0) &&
            (Board.tiles[widget.x][widget.y - 1] ==
                globals.nbrRows * globals.nbrColumns)) {
          print(id.toString() + ' can move left');
        } else {
          print(id.toString() + ' cannot move left');
        }
        if (((widget.x + 1) < globals.nbrRows) &&
            (Board.tiles[widget.x + 1][widget.y] ==
                globals.nbrRows * globals.nbrColumns)) {
          print(id.toString() + ' can move down');
        } else {
          print(id.toString() + ' cannot move down');
        }
        if ((widget.x > 0) &&
            (Board.tiles[widget.x - 1][widget.y] ==
                globals.nbrRows * globals.nbrColumns)) {
          print(id.toString() + ' can move up');
        } else {
          print(id.toString() + ' cannot move up');
        }
      },
      child: Container(
          width: globals.tileSize,
          height: globals.tileSize,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(),
          ),
          child: Center(
            child: Text(id.toString(),
                style: TextStyle(fontSize: globals.tileSize / 2)),
          )),
    );
  }
}

class Board2 {
  //The board is set up for the maximal allowable squares (tiles)
  static final tiles = List.generate(
      globals.maxRows,
      (i) => List.generate(globals.maxCols, (j) => i * globals.maxCols + j + 1,
          growable: false),
      growable: false);

  // Initialized for the current number of squares
  // Setting tiles[i][j] = initial ID
  // The shuffle flag is a precaution to prevent that the
  // setState() call after shuffling undoes the shuffle
  static initTiles(int rows, int cols) {
    if (!globals.shuffleFlag) {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          tiles[i][j] = i * cols + j + 1;
        }
      }
    }
    globals.shuffleFlag = false;
  }

  // Used for shuffling
  static int getRandomIx(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }

  //Shuffle execution: does an interchange per tile
  //i.e. switches the ID's
  static shuffle(int rows, int cols) {
    //print("shuffle routine $rows, $cols");
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        int i = getRandomIx(rows);
        int j = getRandomIx(cols);
        int tem = tiles[i][j];
        tiles[i][j] = tiles[row][col];
        tiles[row][col] = tem;
      }
    }
  }
}
