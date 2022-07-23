import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/accent_solid_shadow_card.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/primary_solid_shadow_card.dart';
import 'package:daily_challenge/shared/widgets/solid_shadow_card/solid_shadow_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RouletteItemWidget extends StatelessWidget {
  final RouletteItem item;

  const RouletteItemWidget({
    super.key,
    required this.item,
  });

  static double? getHeight() {
    return SolidShadowCard.getHeight(_cardBackgroundHeight);
  }

  static double getWidth() {
    return _cardBackgroundHeight + 2 * _horizontalMargin;
  }

  static double get _horizontalMargin => 4.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _horizontalMargin,
      ),
      child: _buildCard(),
    );
  }

  Widget _buildCard() {
    switch (item.type) {
      case RouletteType.success:
        return _buildSuccessCard();
      case RouletteType.failed:
        return _buildFailedCard();
    }
  }

  Widget _buildSuccessCard() {
    return AccentSolidShadowCard(
      backgroundHeight: _cardBackgroundHeight,
      width: _cardBackgroundHeight,
      child: SvgPicture.asset(
        "resources/images/success_coin.svg",
      ),
    );
  }

  Widget _buildFailedCard() {
    return PrimarySolidShadowCard(
      backgroundHeight: _cardBackgroundHeight,
      width: _cardBackgroundHeight,
      child: SvgPicture.asset(
        "resources/images/blue_cry.svg",
      ),
    );
  }

  static double get _cardBackgroundHeight => 87;
}
