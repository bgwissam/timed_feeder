import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timed_feeder/presentation/widgets/ripple_animation.dart';

class RippleButton extends StatefulWidget {
  const RippleButton({Key? key, this.size}) : super(key: key);
  final double? size;
  @override
  _RippleButtonState createState() => _RippleButtonState();
}

class _RippleButtonState extends State<RippleButton> {
  List<Widget> _anims = [];
  int _animationsRunning = 0;
  var _pressed = false;
  Timer? timer;

  //will stop animation
  void animationEnded() {
    _animationsRunning--;
    if (_animationsRunning == 0) {
      setState(() {
        _anims = [];
      });
    }
  }

  //will star the animation
  void _startAnimation() {
    setState(() {
      _anims.add(
          RippleAnimation(animationEnded, key: UniqueKey(), size: widget.size));
    });

    _animationsRunning++;
  }

  void _runRipple() {
    timer = Timer.periodic(Duration(milliseconds: 650), (timer) {
      if (_pressed) {
        _startAnimation();
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                _pressed = true;
              });
              _runRipple();
            },
            onLongPressEnd: (_) {
              setState(() {
                _anims = [];
                _pressed = false;
              });
            },
            child: Container(
                width: (_size.width * widget.size!),
                height: (_size.height * widget.size!),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.orange)),
          ),
        ),
        ..._anims
      ],
    );
  }
}
