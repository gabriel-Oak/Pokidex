import 'package:flutter/material.dart';

class RotationBack extends StatefulWidget {
  final int duration;
  final Widget child;

  RotationBack({@required this.child, this.duration = 1000}) : super();

  @override
  _RotationBackState createState() => _RotationBackState();
}

class _RotationBackState extends State<RotationBack>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    _animationController.repeat();
  }

  @override
  deactivate() {
    super.deactivate();
    _animationController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: widget.child,
      builder: (context, child) => Transform.rotate(
        angle: _animationController.value * 6.3,
        child: child,
      ),
    );
  }
}
