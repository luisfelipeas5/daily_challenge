import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RoulettePageDependencyInjector extends MultiProvider {
  RoulettePageDependencyInjector({
    super.key,
    required Widget child,
  }) : super(
          providers: [
            const BlocProvider(
              create: _newDailyChallengeBlocInstance,
            ),
          ],
          child: child,
        );

  static RouletteBloc _newDailyChallengeBlocInstance(
    BuildContext context,
  ) {
    return RouletteBloc(
      context.read(),
      context.read(),
      context.read(),
    );
  }
}
