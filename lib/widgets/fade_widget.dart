import 'package:flutter/material.dart';

class FadeWidget extends StatefulWidget {
  final Widget child;
  final int? duration;
  final String type;
  const FadeWidget(
      {Key? key, required this.child, this.duration = 1000, this.type = "zoom"})
      : super(key: key);

  @override
  _FadeWidgetState createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget> with TickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> _animation;
  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: widget.duration!),
    vsync: this,
  )..forward();
  late final Animation<Offset> _slideanimation;
  bool _visible = false;

  @override
  initState() {
    super.initState();

    switch (widget.type) {
      case "left":
        _slideanimation = Tween<Offset>(
          begin: const Offset(-0.5, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInCubic,
        ));
        break;
      case "right":
        _slideanimation =
            Tween<Offset>(begin: const Offset(0.5, 0.0), end: Offset.zero)
                .animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInCubic,
        ));
        break;
      case "top":
        _slideanimation = Tween<Offset>(
          begin: const Offset(0.0, -0.5),
          end: const Offset(0.0, 0.0),
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInCubic,
        ));
        break;
      case "bottom":
        _slideanimation =
            Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero)
                .animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInCubic,
        ));
        break;
      case "zoom":
        Future.delayed(Duration.zero, () {
          setState(() {
            _visible = true;
          });
        });
    }
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == "zoom"
        ? AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: widget.duration!),
            child: widget.child,
          )
        : SlideTransition(position: _slideanimation, child: widget.child);
  }
}
