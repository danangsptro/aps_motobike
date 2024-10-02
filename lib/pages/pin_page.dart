import 'package:aps_motobike/models/bike.dart';
import 'package:flutter/material.dart';

class PINPage extends StatefulWidget {
  const PINPage({super.key, required this.bike});
  final Bike bike;

  @override
  State<PINPage> createState() => _PINPageState();
}

class _PINPageState extends State<PINPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}