import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/dialog/app_dialog.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/dialog/dialog_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FailedPage extends StatelessWidget {
  const FailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogOverlay(
      child: AppDialog(
        headerIconSvgPath: "resources/images/blue_cry.svg",
        ctaText: "Sair",
        onCtaTapped: () => onCtaTapped(context),
        child: Padding(
          padding: _paddingEdgeInsets,
          child: _buildContent(context),
        ),
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

  Column _buildContent(BuildContext context) {
    return Column(
      children: [
        Text(
          "Que pena!",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "Você pode tentar\nda próxima vez",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black,
              ),
        ),
      ],
    );
  }

  void onCtaTapped(BuildContext context) {
    final bloc = BlocProvider.of<RouletteBloc>(context);
    bloc.add(RouletteFailedDialogCloseEvent());
  }
}
