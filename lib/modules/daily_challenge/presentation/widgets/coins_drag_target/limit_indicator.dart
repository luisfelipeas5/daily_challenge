import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/blink/blink.dart';
import 'package:flutter/material.dart';

const _animationDuration = Duration(seconds: 1, milliseconds: 500);

class LimitIndicator extends StatelessWidget {
  const LimitIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Blink(
      animationDuration: _animationDuration,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 100,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 4);
        },
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            width: 8,
          );
        },
      ),
    );
  }
}
