import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

enum AnimationType { fade, slideUp, slideLeft }

class AnimatedPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  final AnimationType animationType;
  final Duration duration;
  final String? name;

  AnimatedPageRoute({
    required this.builder,
    this.animationType = AnimationType.slideUp,
    this.duration = const Duration(milliseconds: 600),
    this.name,
  });

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  final bool opaque = false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return builder(context);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (animationType) {
      case AnimationType.fade:
        return FadeScaleTransition(animation: animation, child: child);
      case AnimationType.slideUp:
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.vertical,
          child: child,
        );
      case AnimationType.slideLeft:
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        );
    }
  }
}
