import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.icon,
      required this.hint,
      required this.editingController,
      this.obsecure,
      this.enable = true,
      this.onTapBox});
  final String icon;
  final String hint;
  final TextEditingController editingController;
  final bool? obsecure;
  final bool? enable;
  final VoidCallback? onTapBox;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
