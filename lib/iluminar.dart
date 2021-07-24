import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedIluminarContainer extends StatefulWidget {
  const AnimatedIluminarContainer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

  @override
  State<StatefulWidget> createState() => _AnimatedIluminarContainerState();
}

class _AnimatedIluminarContainerState extends State<AnimatedIluminarContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..animateWith(_RepeatingCurvedSimulation(
        Duration(seconds: 4),
        Curves.easeInOut,
      ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _IluminarPainter(
        angle: (_controller.value * 2 - 1) * (pi / 32),
      ),
      child: widget.builder(context),
    );
  }
}

class _IluminarPainter extends CustomPainter {
  _IluminarPainter({required this.angle});

  static const double _cableWidth = 4;
  static const double _cableHeight = 5;
  static const double _lightShadeWidth = 90;
  static const double _lightShadeHeight = 50;
  static const double _endWidth = 0.6;

  final double angle;

  final _lightPaint = Paint()..color = Colors.black;
  final _foregroundPaint = Paint()
    ..color = Colors.black.withAlpha((255 * 0.9).toInt());
  final _backgroundPaint = Paint()
    ..color = Colors.yellow.withAlpha((255 * 0.4).toInt());

  @override
  void paint(Canvas canvas, Size size) {
    final maxHeight = sqrt(pow(size.width, 2) + pow(size.height, 2));
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, _backgroundPaint);

    final centerX = size.width / 2;
    final lightShadePath = Path()
      ..moveTo(centerX - _cableWidth / 2, 0)
      ..relativeLineTo(_cableWidth, 0)
      ..relativeLineTo(0, _cableHeight)
      ..relativeLineTo(-_cableWidth, 0)
      ..close()
      ..moveTo(centerX - _cableWidth / 2, _cableHeight)
      ..relativeCubicTo(
        -_lightShadeWidth / 4,
        0,
        -_lightShadeWidth / 2 + _lightShadeWidth / 20,
        _lightShadeHeight / 3,
        -_lightShadeWidth / 2,
        _lightShadeHeight,
      )
      ..relativeLineTo(_lightShadeWidth + _cableWidth, 0)
      ..relativeCubicTo(
        -_lightShadeWidth / 20,
        -_lightShadeHeight * 2 / 3,
        -_lightShadeWidth / 4,
        -_lightShadeHeight,
        -_lightShadeWidth / 2 + _cableWidth / 2,
        -_lightShadeHeight,
      )
      ..close();
    final rotateMatrix = Matrix4.identity()
      ..translate(centerX)
      ..rotateZ(angle)
      ..translate(-centerX);
    canvas.drawPath(
      lightShadePath.transform(rotateMatrix.storage),
      _lightPaint,
    );

    final y = _lightShadeHeight + _cableHeight;
    final startWidth = _lightShadeWidth + _cableWidth;
    final endWidth = size.width * _endWidth;
    final lightPath = Path()
      ..moveTo(centerX - startWidth / 2, y)
      ..lineTo(centerX + startWidth / 2, y)
      ..lineTo(centerX + endWidth / 2, maxHeight)
      ..lineTo(centerX - endWidth / 2, maxHeight)
      ..close();
    final basePath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path.combine(
      PathOperation.difference,
      basePath,
      lightPath.transform(rotateMatrix.storage),
    );

    canvas.clipPath(path);
    canvas.drawPath(path, _foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _RepeatingCurvedSimulation extends Simulation {
  _RepeatingCurvedSimulation(
    Duration duration,
    this.curve,
  ) : duration = duration.inMicroseconds / Duration.microsecondsPerSecond;

  final double duration;
  final Curve curve;

  @override
  double x(double time) {
    final x = (time / duration) % 1;
    if ((time ~/ duration).isOdd) {
      return 1 - curve.transform(x);
    }
    return curve.transform(x);
  }

  @override
  double dx(double time) => time;

  @override
  bool isDone(double time) => false;
}
