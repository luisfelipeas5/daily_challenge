import 'package:flutter/material.dart';

class DialogOverlay extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const DialogOverlay({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: const Color.fromRGBO(0, 0, 0, 0.61),
        child: child,
      ),
    );
  }
}
