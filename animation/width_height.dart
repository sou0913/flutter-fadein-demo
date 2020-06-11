import 'package:flutter/material.dart';

void main() => runApp(AnimationRect());

class AnimationRect extends StatefulWidget {
  @override
  _AnimationRectState createState() => _AnimationRectState();
}

class _AnimationRectState extends State<AnimationRect>
    with SingleTickerProviderStateMixin { // 1

  // 2
  Animation<double> animation;
  AnimationController controller;
  final tween = Tween(begin: 50.0, end: 300.0);

  // 3
  @override
  void initState() {
    super.initState();

    // 2000ミリ秒のアニメーション
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    // 50.0 から 300.0 の範囲でアニメーションを行う
    // 状態が書き換わると描画を更新する
    animation = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  // 4
  void startAnimation() {
    // アニメーションの状態を見て
    // 再生するか逆再生するかを決める
    switch (animation.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        controller.forward();
        break;
      case AnimationStatus.completed:
      case AnimationStatus.forward:
        controller.reverse();
        break;
    }
  }

  @override
  Widget build(BuildContext context) { // 5
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text('Start Animation'),
                onPressed: () => startAnimation(),
              ),
              SizedBox(
                // アニメーションオブジェクトから現在の状態を取得して利用する
                width: animation.value,
                height: animation.value,
                child: Container(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}