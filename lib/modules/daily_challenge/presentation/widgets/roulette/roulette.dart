import 'package:daily_challenge/modules/daily_challenge/data/models/roulette_item/roulette_item.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_dimens.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_item_widget.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/roulette/roulette_status.dart';
import 'package:flutter/material.dart';

class Roulette extends StatefulWidget {
  final List<RouletteItem> rouletteItems;
  final RouletteStatus status;
  final int? centerItemIndex;
  final VoidCallback? onSpinningStopped;
  final double initialScrollOffset;
  final Duration spinDuration;

  const Roulette._({
    super.key,
    required this.initialScrollOffset,
    required this.rouletteItems,
    required this.status,
    required this.centerItemIndex,
    required this.spinDuration,
    this.onSpinningStopped,
  });

  factory Roulette.byContext(
    BuildContext context, {
    Key? key,
    required List<RouletteItem> rouletteItems,
    required RouletteStatus status,
    required int? centerItemIndex,
    required Duration spinDuration,
    VoidCallback? onSpinningStopped,
  }) {
    final initialScrollOffset = RouletteDimens.getWidth(context) / 2;
    return Roulette._(
      key: key,
      initialScrollOffset: initialScrollOffset,
      rouletteItems: rouletteItems,
      status: status,
      centerItemIndex: centerItemIndex,
      spinDuration: spinDuration,
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
    if (_statusChangedToSpinning(oldWidget)) {
      final centerItemIndex = widget.centerItemIndex;
      if (centerItemIndex != null) {
        _spin(centerItemIndex);
      }
    } else if (_statusChangedToIdle(oldWidget)) {
      _spinToInitWithDelay();
    }
  }

  bool _statusChangedToSpinning(Roulette oldWidget) =>
      oldWidget.status.idle && widget.status.spinning;

  bool _statusChangedToIdle(Roulette oldWidget) =>
      oldWidget.status.spinning && widget.status.idle;

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

  void _spinToInitWithDelay() async {
    await Future.delayed(const Duration(milliseconds: 700));
    await _scrollController.animateTo(
      widget.initialScrollOffset,
      duration: const Duration(milliseconds: 700),
      curve: Curves.decelerate,
    );
  }

  Future<void> _spin(int centerItemIndex) async {
    final offset = _getOffsetToCenter(centerItemIndex);
    final currentCenterOffset = _getCurrentCenterOffset();
    _spinning = true;
    await _scrollController.animateTo(
      offset - currentCenterOffset,
      duration: widget.spinDuration,
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
