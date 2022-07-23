import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Coin extends StatelessWidget {
  final double size;

  const Coin({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "resources/images/coin.svg",
      width: size,
      height: size,
    );
  }
}
