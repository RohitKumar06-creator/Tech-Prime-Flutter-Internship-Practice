import 'package:flutter/material.dart';

class ListStateWidget extends StatefulWidget {
  const ListStateWidget({super.key});

  @override
  State<ListStateWidget> createState() => _ListStateWidgetState();
}

class _ListStateWidgetState extends State<ListStateWidget> {
  final List<String> _items = [];
  int _itemCounter = 1;

  void _addItem() {
    setState(() {
      _items.add('Task $_itemCounter');
      _itemCounter++;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List State')),
      body: _items.isEmpty
          ? const Center(child: Text('No items yet. Add some!'))
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
