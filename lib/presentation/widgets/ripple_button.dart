import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timed_feeder/fixed/text_styles.dart';
import 'package:timed_feeder/presentation/widgets/ripple_animation.dart';

class RippleButton extends StatefulWidget {
  const RippleButton({Key? key, this.size, this.name, this.route})
      : super(key: key);
  final double? size;
  final String? name;
  final Route? route;
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
        RippleAnimation(animationEnded,
            key: UniqueKey(), size: widget.size, name: widget.name),
      );
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
            onTap: () {
              setState(() {
                _pressed = true;
              });
              Timer(const Duration(seconds: 3), () async {
                setState(() {
                  _pressed = false;
                  _anims = [];
                });
                print('the route: ${widget.route!}');

                await Navigator.push(context, widget.route!);
              });

              _runRipple();
            },
            child: Container(
              width: (_size.width * widget.size!),
              height: (_size.height * widget.size!),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(1, 3))
                  ]),
              child: Center(
                  child: Text(
                widget.name!,
                style: textStyle2,
              )),
            ),
          ),
        ),
        ..._anims
      ],
    );
  }
}
