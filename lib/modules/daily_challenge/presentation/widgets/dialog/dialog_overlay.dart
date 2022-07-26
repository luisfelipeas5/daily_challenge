import 'package:flutter/material.dart';

class DialogOverlay extends StatelessWidget {
  final Widget child;

  const DialogOverlay({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.61),
      child: child,
    );
  }
}
