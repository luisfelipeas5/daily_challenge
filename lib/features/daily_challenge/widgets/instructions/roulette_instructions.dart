import 'package:flutter/material.dart';

class RouletteInstructions extends StatelessWidget {
  const RouletteInstructions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Quer tentar a sorte?",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          "Rode o desafio e ganhe Bits",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
