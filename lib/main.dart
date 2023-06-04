import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Test",
      theme: ThemeData(primarySwatch: Colors.blue),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("人肉计算机 你能答对几个？")),
      body: Stack(
        children: [
          ...List.generate(5, (index) => const Puzzles()),
          const Align(
            alignment: Alignment.bottomCenter,
            child: KeyPad(),
          )
        ],
      ),
    );
  }
}

class Puzzles extends StatefulWidget {
  const Puzzles({Key? key}) : super(key: key);

  @override
  State<Puzzles> createState() => _PuzzlesState();
}

class _PuzzlesState extends State<Puzzles> with SingleTickerProviderStateMixin {
  int a = 0, b = 0, top = 0, left = 0;
  final Color color =
      Colors.primaries[Random().nextInt(Colors.primaries.length)][200]!;
  late AnimationController _controller;

  @override // 重写的需要热重启
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    reset();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // print("完成，重新绘制");
        reset();
      }
    });
  }

  void reset() {
    top = 0;
    a = Random().nextInt(9);
    b = Random().nextInt(9 - a);
    left = Random().nextInt(350);
    _controller.duration = Duration(seconds: Random().nextInt(10) + 2);
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Positioned(
        top: (MediaQuery.of(context).size.height - 300) * _controller.value,
        left: left.toDouble(),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              color: color),
          child: Text(
            "$a + $b =",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class KeyPad extends StatelessWidget {
  const KeyPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        // 网格视图中元素的总数
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 2 / 1),
        itemBuilder: (BuildContext context, int index) {
          return TextButton(
            onPressed: () => handlerKeyPadTapEvent(index),
            child: Container(
              color: Colors.primaries[index % Colors.primaries.length][200],
              alignment: Alignment.center,
              child: Text(
                "${index + 1}",
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  // 点击的是哪项
  void handlerKeyPadTapEvent(int index) {
    print(index);
  }
}
