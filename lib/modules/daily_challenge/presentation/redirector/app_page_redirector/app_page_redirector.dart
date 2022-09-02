import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_page_status.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/failed_page.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _delayRedirection = Duration(microseconds: 800);

class AppPageRedirector extends StatelessWidget {
  const AppPageRedirector({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouletteBloc, RouletteState>(
      listener: _listener,
      child: child,
    );
  }

  void _listener(BuildContext context, RouletteState state) async {
    final navigatorState = Navigator.of(context);
    if (state.pageStatus.isSuccess()) {
      await Future.delayed(_delayRedirection);
    }
    if (_isRedirectPageStatus(state)) {
      await _pushNextPage(
        navigatorState: navigatorState,
        state: state,
      );
    }
  }

  bool _isRedirectPageStatus(RouletteState state) =>
      state.pageStatus.isSuccess() || state.pageStatus.isFailed();

  Future<void> _pushNextPage({
    required NavigatorState navigatorState,
    required RouletteState state,
  }) async {
    await navigatorState.push(
      PageRouteBuilder(
        pageBuilder: (context, a1, a2) {
          return _getNextPage(state);
        },
        opaque: false,
      ),
    );
  }

  Widget _getNextPage(RouletteState state) =>
      state.pageStatus.isSuccess() ? const SuccessPage() : const FailedPage();
}
