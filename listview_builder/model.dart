import 'package:state_notifier/state_notifier.dart';

class Item {
  Item(this.name);
  String name;
}

class ItemsState {
  ItemsState({this.items});
  List<Item> items;
}

class ItemsNotifier extends StateNotifier<ItemsState> with LocatorMixin {
  ItemsNotifier() : super(ItemsState(items: []));
  @override
  void initState() {
    fetchItems();
  }

  Future<void> fetchItems() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));
    state = ItemsState(items: items);
  }

  List<Item> items = [
    Item('listA'),
    Item('ListB'),
    Item('listC'),
    Item('listD'),
    Item('ListE'),
    Item('listF'),
    Item('listG'),
    Item('ListH'),
    Item('listI'),
    Item('listJ'),
    Item('listK'),
    Item('listL'),
    Item('listN')
  ];
}
