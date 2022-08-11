import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_dimens.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_item_widget.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_status.dart';
import 'package:flutter/material.dart';

const _spinDuration = Duration(milliseconds: 3000);

class Roulette extends StatefulWidget {
  final List<RouletteItem> rouletteItems;
  final RouletteStatus status;
  final int? centerItemIndex;
  final VoidCallback? onSpinningStopped;
  final double initialScrollOffset;

  const Roulette._({
    super.key,
    required this.initialScrollOffset,
    required this.rouletteItems,
    required this.status,
    required this.centerItemIndex,
    this.onSpinningStopped,
  });

  factory Roulette.byContext(
    BuildContext context, {
    Key? key,
    required List<RouletteItem> rouletteItems,
    required RouletteStatus status,
    required int? centerItemIndex,
    VoidCallback? onSpinningStopped,
  }) {
    final initialScrollOffset = RouletteDimens.getWidth(context) / 2;
    return Roulette._(
      key: key,
      initialScrollOffset: initialScrollOffset,
      rouletteItems: rouletteItems,
      status: status,
      centerItemIndex: centerItemIndex,
      onSpinningStopped: onSpinningStopped,
    );
  }

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  late ScrollController _scrollController;
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: widget.initialScrollOffset,
    );
  }

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
      height: RouletteItemWidget.getHeight(context),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
      animate: !_spinning,
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
    final offset = _getOffsetToCenter(centerItemIndex);
    final currentCenterOffset = _getCurrentCenterOffset();
    _spinning = true;
    await _scrollController.animateTo(
      offset - currentCenterOffset,
      duration: _spinDuration,
      curve: Curves.decelerate,
    );
    _spinning = false;
    widget.onSpinningStopped?.call();
  }

  double _getOffsetToCenter(int centerItemIndex) {
    final itemWidth = RouletteDimens.getWidth(context);
    return (centerItemIndex * itemWidth) + itemWidth / 2;
  }

  double _getCurrentCenterOffset() {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / 2;
  }
}
