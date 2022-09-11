import 'dart:math';

import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_bloc.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_event.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/bloc/roulette/roulette_state.dart';
import 'package:daily_challenge/modules/daily_challenge/presentation/widgets/blink/blink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _animationDuration = Duration(milliseconds: 750);
const _animationDelay = Duration(milliseconds: 1000);

class LogoSpace extends StatefulWidget {
  const LogoSpace({
    super.key,
  });

  @override
  State<LogoSpace> createState() => _LogoSpaceState();
}

class _LogoSpaceState extends State<LogoSpace> {
  double _imageScale = 0;
  RouletteBloc get _bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    await Future.delayed(_animationDelay);
    setState(() {
      _imageScale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouletteBloc, RouletteState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onDoubleTap: _onDoubleTap,
              onLongPress: _onLongPress,
              child: Blink(
                blinking: state.logoBlinking,
                animationDuration: const Duration(seconds: 2),
                child: Logo(
                  scale: _imageScale,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onDoubleTap() {
    setState(() {
      _imageScale = max(_imageScale * 0.8, 0.1);
      _addScaleEventToBloc();
    });
  }

  void _onLongPress() {
    setState(() {
      _imageScale = min(_imageScale * 1.3, 1);
      _addScaleEventToBloc();
    });
  }

  void _addScaleEventToBloc() {
    _bloc.add(
      RouletteLogoScaleUpdatedEvent(scale: _imageScale),
    );
  }
}

class Logo extends StatelessWidget {
  final double scale;

  const Logo({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: AnimatedScale(
        duration: _animationDuration,
        curve: Curves.elasticInOut,
        scale: scale,
        child: Image.asset(
          "resources/images/logo.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
