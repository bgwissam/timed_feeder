import 'package:flutter/material.dart';
import 'package:timed_feeder/fixed/text_styles.dart';

class RippleAnimation extends StatefulWidget {
  const RippleAnimation(this.endedCallBack, {Key? key, this.size, this.name})
      : super(key: key);
  final VoidCallback? endedCallBack;
  final double? size;
  final String? name;
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
    _color = ColorTween(
            begin: Colors.orange, end: Colors.yellow.withOpacity(0.2))
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
              child: Center(child: Text(widget.name!, style: textStyle2)),
              width: _scale.value * (_size.width * widget.size!),
              height: _scale.value * (_size.height * widget.size!),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _color.value,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 1))
                  ]),
            ),
          );
        });
  }
}
