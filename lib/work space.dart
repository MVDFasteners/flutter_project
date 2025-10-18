import 'package:flutter/material.dart';

class MyListViewBuilder extends StatelessWidget {
  final List<String> items = List<String>.generate(100, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView.builder Example'),
      ),
      body: ListView.builder(
        itemCount: items.length, // Total number of items
        itemBuilder: (BuildContext context, int index) {
          // Build each item based on its index
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(items[index]),
              subtitle: Text('This is a subtitle for ${items[index]}'),
              leading: Icon(Icons.list),
              onTap: () {
                // Handle item tap
                print('Tapped on ${items[index]}');
              },
            ),
          );
        },
      ),
    );
  }
}