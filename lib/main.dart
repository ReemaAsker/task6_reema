import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(18, 5, 56, 5),
        body: paper_rock(),
      ),
    );
  }
}

class paper_rock extends StatefulWidget {
  const paper_rock({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _paper_rock();
  }
}

class _paper_rock extends State<StatefulWidget> {
  late int rightimg;
  late int leftimg;

  List<Icon> leftIcons = [];
  List<Icon> rightIcons = [];
  List<Icon> equalIcons = [];

//1  rock
//2  sciss
//3  paper
  @override
  void initState() {
    rightimg = 1;
    leftimg = 2;
  }

  void change() {
    setState(() {
      leftimg = math.Random().nextInt(3) + 1;
      rightimg = math.Random().nextInt(3) + 1;

      the_win();
    });
  }

  void end_play() {
    // if (leftIcons.length * 24 >=
    //         MediaQuery.of(context).size.width.toInt() - 100 ||
    //     rightIcons.length * 24 >=
    //         MediaQuery.of(context).size.width.toInt() - 100 ||
    //     equalIcons.length * 24 >=
    //         MediaQuery.of(context).size.width.toInt() - 100) {
    // print('${leftIcons.length} ,${equalIcons.length},${rightIcons.length}');
    if (leftIcons.length == 12 ||
        rightIcons.length == 12 ||
        equalIcons.length == 12) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: leftIcons.length != 12
                        ? const Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: Colors.red,
                            size: 150,
                          )
                        : const Icon(
                            Icons.sentiment_satisfied_alt,
                            color: Colors.green,
                            size: 150,
                          )),
              ),
              const Center(
                child: Text(
                  'END Game',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'YOUR SCORE IS ${leftIcons.length} /12',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              TextButton(
                child: Container(
                  margin: const EdgeInsets.all(45.0),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blue),
                  child: const Center(
                    child: Text(
                      'Play Again',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        },
      );
    }
  }

  void the_win() {
    end_play();

    if (leftimg == 1 && rightimg == 2 ||
        leftimg == 2 && rightimg == 3 ||
        leftimg == 3 && rightimg == 1) {
      leftIcons.add(Icon(Icons.thumb_up_alt, color: Colors.purple));
    } else if (leftimg == 1 && rightimg == 3 ||
        leftimg == 2 && rightimg == 1 ||
        leftimg == 3 && rightimg == 2) {
      rightIcons.add(Icon(Icons.thumb_up_alt, color: Colors.teal[700]));
    } else {
      equalIcons.add(Icon(Icons.diamond_sharp, color: Colors.amber));
    }
    end_play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Image(
            height: 200,
            width: 200,
            image: AssetImage('images/name1.png'),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/backplay.jpg'), fit: BoxFit.cover),
          ),
          child: Row(
            children: [
              Expanded(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: TextButton(
                      onPressed: change,
                      child: Image.asset('images/img$leftimg.png')),
                ),
              ),
              Expanded(
                child: TextButton(
                    onPressed: change,
                    child: Image.asset('images/img$rightimg.png')),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'You   ',
                style: TextStyle(color: Colors.purple, fontSize: 35.0),
              ),
              Text(
                '      System',
                style: TextStyle(color: Colors.teal[700], fontSize: 35.0),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(children: [
            Expanded(
              child: Column(
                children: leftIcons,
              ),
            ),
            Expanded(
              child: Column(
                children: equalIcons,
              ),
            ),
            Expanded(
              child: Column(
                children: rightIcons,
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
