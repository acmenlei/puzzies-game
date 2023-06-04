import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/keypad.dart';
import 'package:flutter_app/puzzles.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Test",
      theme: ThemeData(primarySwatch: Colors.green),
      home: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final StreamController _streamController = StreamController.broadcast();
  late final StreamController _scoreController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _scoreController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: PuzzlesScore(scoreController: _scoreController)),
      body: Stack(
        children: [
          ...List.generate(
              5,
              (index) => Puzzles(
                  key: ValueKey(index),
                  stream: _streamController,
                  scoreController: _scoreController)),
          Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(stream: _streamController),
          )
        ],
      ),
    );
  }
}

class PuzzlesScore extends StatefulWidget {
  late StreamController scoreController;

  PuzzlesScore({Key? key, required this.scoreController}) : super(key: key);

  @override
  State<PuzzlesScore> createState() => _PuzzlesScoreState();
}

class _PuzzlesScoreState extends State<PuzzlesScore> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    widget.scoreController.stream.listen((event) {
      setState(() {
        score += event as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('目前得分: $score');
  }
}
