import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'model.dart';

void main() {
  runApp(
    MaterialApp(
        home: StateNotifierProvider<ItemsNotifier, ItemsState>(
            create: (context) => ItemsNotifier(), child: Demo())),
  );
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = context.select((ItemsState s) => s.items);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Demo'),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: _myTile,
        ));
  }

  Widget _myTile(BuildContext context, int index) {
    final items = context.select((ItemsState s) => s.items);
    return ListTile(title: Text(items[index].name));
  }
}
