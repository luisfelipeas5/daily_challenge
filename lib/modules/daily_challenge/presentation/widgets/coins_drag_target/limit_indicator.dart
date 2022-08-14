import 'package:flutter/material.dart';

class LimitIndicator extends StatelessWidget {
  const LimitIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
