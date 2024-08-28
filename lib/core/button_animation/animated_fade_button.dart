import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_plantist_app/core/button_animation/fade_zoom_transition.dart';
import 'package:simple_animations/simple_animations.dart';


class AnimatedFadeButton extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  final VoidCallback onTap;
  final bool visible;
  final double minValue;
  final HitTestBehavior behavior;

  const AnimatedFadeButton({
    super.key,
    required this.child,
    this.duration,
    required this.onTap,
    this.visible = true,
    this.minValue = .7,
    this.behavior = HitTestBehavior.translucent,
  });

  @override
  State<AnimatedFadeButton> createState() => _AnimatedFadeButtonState();
}

class _AnimatedFadeButtonState extends State<AnimatedFadeButton>
    with AnimationMixin {
  late Animation<double> _animation;
  late AnimationController _visibleController;
  late Animation<double> _visibleAnimation;
  late bool _showing = widget.visible;

  @override
  void initState() {
    super.initState();

    _visibleController = createController();
    _visibleController.duration = const Duration(milliseconds: 100);
    _animation = Tween(begin: widget.minValue, end: 1.0).animate(controller);
    _visibleAnimation = Tween(begin: 0.0, end: 1.0).animate(_visibleController);
    controller.duration = widget.duration ?? const Duration(milliseconds: 100);
    controller.forward(from: 1.0);
    _visibleController.animateTo(1.0);
    _visibleController.addListener(() {
      setState(() {
        _showing = _visibleController.value > .1;
      });
    });
  }

  @override
  void didUpdateWidget(covariant AnimatedFadeButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (oldWidget.visible != widget.visible) {
    _visibleController.animateTo(widget.visible ? 1.0 : 0.0);
    // }
  }

  var hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _visibleAnimation,
      builder: (_, child) => Opacity(
        opacity: _visibleAnimation.value,
        child: IgnorePointer(
          ignoring: !_showing,
          child: GestureDetector(
            behavior: widget.behavior,
            onTapCancel: () => setHovering(false),
            onTapUp: (details) => setHovering(false),
            onTapDown: (details) => setHovering(true),
            onTap: () {
              setHovering(false);
              widget.onTap();
            },
            child: FadeZoomTransition(
              routeAnimation: _animation,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  setHovering(bool isHovering) async {
    if (controller.isAnimating) {
      final animationCompleter = Completer<void>();

      listener() {
        if (!controller.isAnimating) {
          animationCompleter.complete();
        }
      }

      controller.addListener(listener);
      await animationCompleter.future;
      controller.removeListener(listener);
      if (!isHovering) {
        controller.play();
      } else {
        controller.playReverse();
      }
      hovering = isHovering;
    } else {
      if (!isHovering) {
        controller.play();
      } else {
        controller.playReverse();
      }
      hovering = isHovering;
    }
  }
}
