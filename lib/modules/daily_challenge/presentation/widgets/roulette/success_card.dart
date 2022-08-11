import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_dimens.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/accent_solid_shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessCard extends StatelessWidget {
  final bool animate;

  const SuccessCard({
    super.key,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    final cardBackgroundHeight =
        RouletteDimens.getCardBackgroundHeight(context);
    return AccentSolidShadowCard(
      backgroundHeight: cardBackgroundHeight,
      width: cardBackgroundHeight,
      animate: animate,
      child: SvgPicture.asset(
        "resources/images/success_coin.svg",
      ),
    );
  }
}
