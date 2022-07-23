import 'package:flutter/material.dart';

class BiasAlignment extends StatelessWidget {
  final double horizontalBias;
  final double verticalBias;
  final Widget child;

  const BiasAlignment({
    super.key,
    required this.horizontalBias,
    required this.verticalBias,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final topAligment = Alignment.lerp(
      Alignment.topLeft,
      Alignment.topRight,
      horizontalBias,
    );
    final bottomAligment = Alignment.lerp(
      Alignment.bottomLeft,
      Alignment.bottomRight,
      horizontalBias,
    );
    return Align(
      alignment: Alignment.lerp(
        topAligment,
        bottomAligment,
        verticalBias,
      )!,
      child: child,
    );
  }
}
