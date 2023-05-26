import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(18, 5, 56, 5),
        body: paper_rock(),
      ),
    );
  }
}

class paper_rock extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _paper_rock();
  }
}

class _paper_rock extends State<StatefulWidget> {
  late int rightimg;
  late int leftimg;
  bool lwin = false;
  bool rwin = false;
  String res = 'Equal';
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

  void the_win() {
    if (leftimg == 1 && rightimg == 2) {
      lwin = true;
    } else if (leftimg == 1 && rightimg == 3) {
      rwin = true;
    } else if (leftimg == 2 && rightimg == 1) {
      rwin = true;
    } else if (leftimg == 2 && rightimg == 3) {
      lwin = true;
    } else if (leftimg == 3 && rightimg == 1) {
      lwin = true;
    } else if (leftimg == 3 && rightimg == 2) {
      rwin = true;
    }
    if (lwin) {
      lwin = false;
      res = 'Left';
    } else if (rwin) {
      rwin = false;
      res = 'Right';
    } else {
      res = 'Equal';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Image(
          height: 200,
          width: 200,
          image: AssetImage('images/name1.png'),
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.all(24.0),
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
        Column(
          children: [
            Text(
              'The win is the',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            Text(
              '$res',
              style: TextStyle(color: Colors.red, fontSize: 30.0),
            ),
          ],
        ),
      ],
    );
  }
}
