import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';

class LeadScreen extends StatefulWidget {
  const LeadScreen({super.key});

  @override
  State<LeadScreen> createState() => _LeadScreenState();
}

class _LeadScreenState extends State<LeadScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(child: Container(color: Colors.red, height: 200));
  }
}
