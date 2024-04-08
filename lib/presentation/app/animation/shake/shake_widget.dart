import 'package:flutter/material.dart';
import 'package:lab_test_app/presentation/app/animation/shake/animation_controller_state.dart';
import 'package:lab_test_app/presentation/app/animation/shake/sine_curve.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget(
      {super.key,
      required this.child,
      required this.shakeOffset,
      required this.shakeCount,
      required this.shakeDuration});

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  State<ShakeWidget> createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ShakeWidget> {
  ShakeWidgetState(Duration duration) : super(duration);

  late final Animation<double> _sineAnimation = Tween(begin: 1.0, end: 2.0)
      .animate(CurvedAnimation(
          parent: animationController,
          curve: SineCurve(count: widget.shakeCount.toDouble())));

  @override
  void initState() {
    animationController.addStatusListener((_updateStatus));
    super.initState();
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sineAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_sineAnimation.value * widget.shakeOffset, 0),
          child: child,
        );
      },
    );
  }


}
