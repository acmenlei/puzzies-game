import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Puzzles extends StatefulWidget {
  final StreamController stream;
  final StreamController scoreController;

  const Puzzles({Key? key, required this.stream, required this.scoreController})
      : super(key: key);

  @override
  State<Puzzles> createState() => _PuzzlesState();
}

class _PuzzlesState extends State<Puzzles> with SingleTickerProviderStateMixin {
  int a = 0, b = 0, left = 0;
  late Color color;
  late AnimationController _controller;

  @override // 重写的需要热重启
  void initState() {
    super.initState();
    // 初始化动画控制器
    _controller = AnimationController(vsync: this);
    // 初始化题目位置信息
    reset();
    // 监听动画状态：正在执行 || 已经完成
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.scoreController.sink.add(-3);
        reset();
        _controller.forward(from: 0.0);
      }
    });
    // 监听键盘的输入内容，判断答案是否正确
    widget.stream.stream.listen((event) {
      if (event == a + b) {
        widget.scoreController.sink.add(5);
        reset();
        // 动画继续从0开始播放
        _controller.forward(from: 0.0);
      }
    });
    // 初始化开始位置
    _controller.forward(from: Random().nextDouble());
  }

  void reset() {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(9 - a);
    left = Random().nextInt(350);
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200]!;
    _controller.duration = Duration(seconds: Random().nextInt(10) + 2);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose(); // 销毁
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => Positioned(
        top: (deviceHeight - 350) * _controller.value,
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
