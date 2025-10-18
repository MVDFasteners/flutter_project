import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';

class Stock extends StatefulWidget {
  const Stock({super.key});

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return Layout(child: Center(child: Text("Stock Page")));
  }
}
