import 'package:flutter/material.dart';

class RippleAnimation extends StatefulWidget {
  const RippleAnimation(this.endedCallBack, {Key? key, this.size})
      : super(key: key);
  final VoidCallback? endedCallBack;
  final double? size;
  @override
  _RippleAnimationState createState() => _RippleAnimationState();
}

class _RippleAnimationState extends State<RippleAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _color;
  late final Animation<double> _scale;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              if (mounted) {
                widget.endedCallBack;
              }
            }
          });
    _scale = Tween<double>(begin: 1, end: 1.3).animate(_controller);
    _color = Tween<Color>(
            begin: Colors.orange, end: Colors.orange.withOpacity(0.2))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    _controller.forward();
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Center(
            child: Container(
              width: (_size.width * widget.size!) * _scale.value,
              height: (_size.width * widget.size!) * _scale.value,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: _color.value),
            ),
          );
        });
  }
}
