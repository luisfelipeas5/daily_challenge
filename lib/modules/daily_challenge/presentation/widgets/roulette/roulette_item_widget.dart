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

  static double? getHeight(BuildContext context) {
    final cardBackgroundHeight = _getCardBackgroundHeight(context);
    return SolidShadowCard.getHeight(cardBackgroundHeight);
  }

  static double getWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / _itemPerScreen;
  }

  static double _getCardBackgroundHeight(BuildContext context) =>
      getWidth(context) - (_horizontalMargin * 2);

  static double get _horizontalMargin => 4.5;

  static const int _itemPerScreen = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: _horizontalMargin,
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
    final cardBackgroundHeight = _getCardBackgroundHeight(context);
    return AccentSolidShadowCard(
      backgroundHeight: cardBackgroundHeight,
      width: cardBackgroundHeight,
      child: SvgPicture.asset(
        "resources/images/success_coin.svg",
      ),
    );
  }

  Widget _buildFailedCard(BuildContext context) {
    final cardBackgroundHeight = _getCardBackgroundHeight(context);
    return PrimarySolidShadowCard(
      backgroundHeight: cardBackgroundHeight,
      width: cardBackgroundHeight,
      child: SvgPicture.asset(
        "resources/images/blue_cry.svg",
      ),
    );
  }
}
