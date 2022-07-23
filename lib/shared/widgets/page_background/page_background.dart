import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageBackground extends StatelessWidget {
  final Widget? child;

  const PageBackground({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getDecoration(),
      child: Stack(
        children: [
          _buildStar(),
          _buildChild(),
        ],
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return const BoxDecoration(
      gradient: RadialGradient(
        colors: [
          Color.fromRGBO(116, 213, 255, 1),
          Color.fromRGBO(0, 71, 255, 1),
        ],
      ),
    );
  }

  Widget _buildChild() => child ?? Container();

  Widget _buildStar() {
    return Center(
      child: Opacity(
        opacity: 0.2,
        child: SvgPicture.asset(
          "resources/images/star.svg",
        ),
      ),
    );
  }
}
