import 'package:flutter/material.dart';

class AnimatedIcon extends StatefulWidget {
  final Widget icon;
  final Duration duration;
  final Curve curve;

  const AnimatedIcon({
    required this.icon,
    this.curve = Curves.elasticOut,
    this.duration = const Duration(seconds: 1),
  });

  @override
  State createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animationController.forward(from: 0);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ),
      child: widget.icon,
    );
  }
}
