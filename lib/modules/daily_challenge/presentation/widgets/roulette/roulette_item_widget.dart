import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_dimens.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/success_card.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/primary_solid_shadow_card.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/solid_shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RouletteItemWidget extends StatelessWidget {
  final RouletteItem item;
  final bool animate;

  const RouletteItemWidget({
    super.key,
    required this.item,
    required this.animate,
  });

  static double? getHeight(BuildContext context) {
    final cardBackgroundHeight =
        RouletteDimens.getCardBackgroundHeight(context);
    return SolidShadowCard.getHeight(cardBackgroundHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: RouletteDimens.horizontalMargin,
      ),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    switch (item.type) {
      case RouletteType.success:
        return _buildSuccessCard(context);
      case RouletteType.failed:
        return _buildFailedCard(context);
    }
  }

  Widget _buildSuccessCard(BuildContext context) {
    return SuccessCard(
      animate: animate,
    );
  }

  Widget _buildFailedCard(BuildContext context) {
    final cardBackgroundHeight =
        RouletteDimens.getCardBackgroundHeight(context);
    return PrimarySolidShadowCard(
      backgroundHeight: cardBackgroundHeight,
      width: cardBackgroundHeight,
      animate: animate,
      child: SvgPicture.asset(
        "resources/images/blue_cry.svg",
      ),
    );
  }
}
