import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_item_widget.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_status.dart';
import 'package:flutter/material.dart';

const _spinDuration = Duration(milliseconds: 3000);

class Roulette extends StatefulWidget {
  final List<RouletteItem> rouletteItems;
  final RouletteStatus status;
  final int? centerItemIndex;
  final VoidCallback? onSpinningStopped;

  const Roulette({
    super.key,
    required this.rouletteItems,
    required this.status,
    required this.centerItemIndex,
    this.onSpinningStopped,
  });

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  final _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant Roulette oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status.idle && widget.status.spinning) {
      final centerItemIndex = widget.centerItemIndex;
      if (centerItemIndex != null) {
        _spin(centerItemIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.rouletteItems.isEmpty) return Container();

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
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: _itemBuilder,
      ),
    );
  }

  Widget _itemBuilder(context, index) {
    var itemLength = widget.rouletteItems.length;
    final rouletteItem = widget.rouletteItems[index % itemLength];
    return RouletteItemWidget(
      item: rouletteItem,
    );
  }

  Widget _buildCenterIndicator() {
    return Container(
      color: Colors.white,
      width: 2,
      height: 200,
    );
  }

  Future<void> _spin(int centerItemIndex) async {
    final itemWidth = RouletteItemWidget.getWidth();
    final offset = centerItemIndex * itemWidth;

    await _scrollController.animateTo(
      offset,
      duration: _spinDuration,
      curve: Curves.decelerate,
    );
    widget.onSpinningStopped?.call();
  }
}
