import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:provider/provider.dart';

class FadeInDemoState {
  FadeInDemoState({this.isLoading});
  bool isLoading;
}

class FadeInDemoNotifier extends StateNotifier<FadeInDemoState>
    with LocatorMixin {
  FadeInDemoNotifier() : super(FadeInDemoState(isLoading: true));
  @override
  void initState() {
    waiting();
  }

  Future<void> waiting() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    state = FadeInDemoState(isLoading: false);
  }
}

void main() {
  runApp(
    MaterialApp(
        home: StateNotifierProvider<FadeInDemoNotifier, FadeInDemoState>(
            create: (context) => FadeInDemoNotifier(), child: FadeInDemo())),
  );
}

class FadeInDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((FadeInDemoState s) => s.isLoading);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fade in Demo'),
        centerTitle: true,
      ),
      body: AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: const Duration(milliseconds: 1000),
          child: ListView(children: const [
            ListTile(
              title: Text('list A'),
            ),
            ListTile(
              title: Text('list B'),
            ),
            ListTile(
              title: Text('list C'),
            )
          ])),
    );
  }
}
