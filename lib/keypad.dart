import 'dart:async';

import 'package:flutter/material.dart';

class KeyPad extends StatelessWidget {
  final StreamController stream;

  const KeyPad({Key? key, required this.stream}) : super(key: key);

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
            onPressed: () => stream.sink.add(index + 1),
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
}
