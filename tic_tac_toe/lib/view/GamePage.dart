import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GamePage extends StatefulWidget {
  final String player1;
  final String player2;

  const GamePage({Key? key, required this.player1, required this.player2})
      : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String winner = '';
  bool xTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  List<String> displayElement = List.filled(9, '');

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      displayElement = List.filled(9, '');
      filledBoxes = 0;
    });
  }

  void _clearBoard() {
    setState(() {
      displayElement = List.filled(9, '');
      filledBoxes = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic X Tac O Toe"),
      ),
      body: Stack(
        children: [
          Image(
              image: const AssetImage('assets/images/bg.jpg'),
              fit: BoxFit.cover,
              height: size.height,
              width: size.width),
          SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              children: <Widget>[
                Expanded(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.player1,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.orange,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                xScore.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                widget.player2,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.orange,
                                      offset: Offset(2.0, 2.0),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                oScore.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: 9,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.yellowAccent,
                              width: 4,
                            ),
                            boxShadow: const [
                              // BoxShadow(
                              //   color: Color.fromARGB(255, 241, 252, 85),
                              //   offset: Offset(
                              //     5.0,
                              //     5.0,
                              //   ),
                              //   blurRadius: 10.0,
                              //   spreadRadius: 2.0,
                              // ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              displayElement[index],
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 60),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellowAccent),
                            onPressed: _clearScoreBoard,
                            child: const Text('Clear Score Board',
                                style: TextStyle(color: Colors.red))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
//When selected columns and rows X or O will be filled

  void _tapped(int index) {
    if (displayElement[index] == '') {
      setState(() {
        displayElement[index] = xTurn ? 'X' : 'O';
        filledBoxes++;
        xTurn = !xTurn;
        _checkWinner();
        xTurn
            ? Fluttertoast.showToast(msg: '${widget.player1} Turn')
            : Fluttertoast.showToast(msg: '${widget.player2} Turn');
      });
    }
  }

//Probabilities for winning
  void _checkWinner() {
    final List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    //condition for winning

    for (final condition in winningConditions) {
      if (displayElement[condition[0]] == displayElement[condition[1]] &&
          displayElement[condition[1]] == displayElement[condition[2]] &&
          displayElement[condition[0]] != '') {
        setState(() {
          winner = displayElement[condition[0]] == 'X'
              ? widget.player1
              : widget.player2;
        });
        _showWinDialog();
        return;
      }
    }

    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

//pop up to show winning
  void _showWinDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner is Winner!!!'),
          actions: [
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (winner == widget.player1) {
      setState(() {
        xScore++;
      });
    } else if (winner == widget.player2) {
      setState(() {
        oScore++;
      });
    }
  }

//pop up to show draw
  void _showDrawDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Draw"),
          actions: [
            TextButton(
              child: const Text("Play Again"),
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
