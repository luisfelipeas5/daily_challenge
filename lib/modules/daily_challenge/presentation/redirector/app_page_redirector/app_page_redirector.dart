import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/failed_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/roulette_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _delayRedirection = Duration(microseconds: 800);

class AppPageRedirector extends StatefulWidget {
  const AppPageRedirector({
    super.key,
  });

  @override
  State<AppPageRedirector> createState() => _AppPageRedirectorState();
}

class _AppPageRedirectorState extends State<AppPageRedirector> {
  bool redirectAllowed = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RouletteBloc, RouletteState>(
      listener: _listener,
      builder: _builder,
    );
  }

  void _listener(BuildContext context, RouletteState state) async {
    if (state.pageStatus.isSuccess()) {
      await Future.delayed(_delayRedirection);
    }
    setState(() {
      redirectAllowed =
          state.pageStatus.isFailed() || state.pageStatus.isSuccess();
    });
  }

  Widget _builder(BuildContext context, RouletteState state) {
    return Stack(
      children: [
        const RoulettePage(),
        if (state.pageStatus.isSuccess() && redirectAllowed)
          const SuccessPage(),
        if (state.pageStatus.isFailed() && redirectAllowed) const FailedPage(),
      ],
    );
  }
}
