import 'package:daily_challenge/shared/widgets/solid_shadow_card/dialog_container_card.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/text_card_button.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final Widget header;
  final String ctaText;
  final VoidCallback onCtaTapped;
  final Widget child;

  const AppDialog({
    super.key,
    required this.ctaText,
    required this.header,
    required this.onCtaTapped,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        fit: StackFit.loose,
        children: [
          _buildCard(context),
          _buildHeaderIcon(),
          _buildCta(),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          DialogContainerCard(
            width: 333,
            child: child,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon() {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: 100,
        width: 100,
        child: header,
      ),
    );
  }

  Widget _buildCta() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: TextCardButton(
        text: ctaText,
        onTap: onCtaTapped,
        minWidth: 152,
        size: TextCardButtonSize.small,
      ),
    );
  }
}
