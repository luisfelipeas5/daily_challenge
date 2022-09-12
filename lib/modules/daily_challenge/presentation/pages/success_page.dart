import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/dialog/app_dialog.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/dialog/dialog_overlay.dart';
import 'package:daily_challenge/shared/widgets/coin/sensor_coin.dart';
import 'package:daily_challenge/shared/widgets/coins_background/dailog_coins_background.dart';
import 'package:daily_challenge/shared/widgets/rotate/rotate.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DialogOverlay(
      child: DialogCoinsBackground(
        child: AppDialog(
          header: _buildHeaderCoin(),
          ctaText: "Resgatar",
          onCtaTapped: () => onCtaTapped(context),
          child: Padding(
            padding: _paddingEdgeInsets,
            child: _buildDialogText(context),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCoin() {
    const size = 100.0;
    return const Rotate(
      animationDuration: Duration(seconds: 2),
      centerX: size / 2,
      centerY: size / 2,
      child: SensorCoin(
        size: size,
      ),
    );
  }

  EdgeInsets get _paddingEdgeInsets {
    return const EdgeInsets.only(
      left: 24,
      right: 24,
      top: 66,
      bottom: 48,
    );
  }

  Column _buildDialogText(BuildContext context) {
    return Column(
      children: [
        Text(
          "Você gannhou!",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
              ),
        ),
        Text(
          "50 bits",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: const Color.fromRGBO(0, 71, 255, 1),
              ),
        ),
      ],
    );
  }

  void onCtaTapped(BuildContext context) => Navigator.pop(context);
}
