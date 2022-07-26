import 'package:flutter/material.dart';

class DoubleDirectionAlignment extends StatelessWidget {
  final double horizontal;
  final double vertical;
  final Widget child;

  const DoubleDirectionAlignment({
    super.key,
    required this.horizontal,
    required this.vertical,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final topAligment = Alignment.lerp(
      Alignment.topLeft,
      Alignment.topRight,
      horizontal,
    );
    final bottomAligment = Alignment.lerp(
      Alignment.bottomLeft,
      Alignment.bottomRight,
      horizontal,
    );
    return Align(
      alignment: Alignment.lerp(
        topAligment,
        bottomAligment,
        vertical,
      )!,
      child: child,
    );
  }
}
