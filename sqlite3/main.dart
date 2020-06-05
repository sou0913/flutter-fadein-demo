import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:provider/provider.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

void main() {
  runApp(Demo());
}

class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<DemoNotifier, DemoState>(
      create: (context) => DemoNotifier(),
      builder: (context, child) {
        final myMaps = context.select((DemoState s) => s.myMaps);
        return MaterialApp(
          title: 'Demo',
          home: Scaffold(
            appBar: AppBar(title: const Text('sqlite min')),
            body: Center(child: Text(myMaps[0]['name'].toString())),
          ),
        );
      },
    );
  }
}

class DemoState {
  DemoState(this.myMaps);
  List<Map<String, dynamic>>  myMaps;
}

class DemoNotifier extends StateNotifier<DemoState> with LocatorMixin {
  DemoNotifier() : super(DemoState(null));

  @override
  Future<void> initState() async {
    final _database = await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
    await _database.insert(
      'dogs',
      <String, dynamic>{'id': 1, 'name': 'poti', 'age': 2},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    final maps = await _database.query('dogs');
    state = DemoState(maps);
  }
}
