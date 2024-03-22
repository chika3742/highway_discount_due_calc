import 'package:flutter/material.dart';

class BulletedListItem extends StatelessWidget {
  final Widget child;

  const BulletedListItem({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.brightness_1, size: 8),
        const SizedBox(width: 8.0),
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
