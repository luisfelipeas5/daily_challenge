import 'package:daily_challenge/shared/widgets/solid_shadow_card/text_card_button.dart';
import 'package:flutter/material.dart';

class RunButton extends StatelessWidget {
  const RunButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TextCardButton(
      text: "Rodar",
      minWidth: 213,
    );
  }
}
