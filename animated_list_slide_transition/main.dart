import 'package:flutter/material.dart';

class Item {
  Item(this.name);
  String name;
}

List<Item> items = [
  Item('listA'),
  Item('ListB'),
  Item('listC'),
];

void main() {
  runApp(
    MaterialApp(home: Demo()),
  );
}

class Demo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  void _insert(Item item) {
    items.add(item);
    _listKey.currentState.insertItem(items.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(items.length.toString()),
        ),
        body: AnimatedList(
          key: _listKey,
          initialItemCount: items.length,
          itemBuilder: _myTile,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.add,
            ),
            onPressed: () => _insert(Item('added item'))));
  }

  Widget _myTile(BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: animation.drive(Tween<Offset>(
          begin: const Offset(1.5, 0), end: Offset.zero)),
      child: ListTile(title: Text(items[index].name)),
    );
  }
}
