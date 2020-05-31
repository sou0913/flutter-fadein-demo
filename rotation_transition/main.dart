import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(Demo());
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Demo',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Demo'),
            ),
            body: Center(child: Home())));
  }
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int time = 60;a
  Widget timeWidget = const Text('');
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (time < 2) {
        _timer.cancel();
      }
      time -= 2;
      setState(() {
        timeWidget = Text(time.toString(),
            style: const TextStyle(fontSize: 30), key: ValueKey(time));
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 1000),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            RotationTransition(
              turns: animation,
              child: child,
            ),
        child: timeWidget);
  }
}
