import 'package:flutter/material.dart';

class NeumorphicBox extends StatelessWidget {
  final Widget child;
  const NeumorphicBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
      return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8.0,
            offset: const Offset(4.0, 4.0),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            blurRadius: 8.0,
            offset: const Offset(-4.0, -4.0),
          ),
        ],
      ),
      child: child,
    );
  }
}
