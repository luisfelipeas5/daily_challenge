import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(45),
          child: Image.asset(
            "resources/images/logo.png",
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
