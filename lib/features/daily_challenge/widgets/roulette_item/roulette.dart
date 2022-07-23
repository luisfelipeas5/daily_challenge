import 'package:daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/features/daily_challenge/widgets/roulette_item/roulette_item_widget.dart';
import 'package:flutter/material.dart';

class Roulette extends StatelessWidget {
  final List<RouletteItem> rouletteItems;

  const Roulette({
    super.key,
    required this.rouletteItems,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildList(),
        _buildCenterIndicator(),
      ],
    );
  }

  Widget _buildList() {
    return SizedBox(
      height: RouletteItemWidget.getHeight(),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final rouletteItem = rouletteItems[index % rouletteItems.length];
          return RouletteItemWidget(
            item: rouletteItem,
          );
        },
      ),
    );
  }

  Widget _buildCenterIndicator() {
    return Container(
      color: Colors.white,
      width: 2,
      height: 200,
    );
  }
}
