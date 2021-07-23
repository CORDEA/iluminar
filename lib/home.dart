import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        foregroundPainter: _IluminarPainter(),
        child: Center(
          child: Text(
            'Iluminar',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}

class _IluminarPainter extends CustomPainter {
  static const double _cableWidth = 4;
  static const double _cableHeight = 5;
  static const double _lightShadeWidth = 90;
  static const double _lightShadeHeight = 50;
  static const double _endWidth = 0.6;

  final _lightPaint = Paint()..color = Colors.black;
  final _foregroundPaint = Paint()
    ..color = Colors.black.withAlpha((255 * 0.9).toInt());
  final _backgroundPaint = Paint()
    ..color = Colors.yellow.withAlpha((255 * 0.4).toInt());

  @override
  void paint(Canvas canvas, Size size) {
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
    canvas.drawPath(lightShadePath, _lightPaint);

    final y = _lightShadeHeight + _cableHeight;
    final startWidth = _lightShadeWidth + _cableWidth;
    final endWidth = size.width * _endWidth;
    final lightPath = Path()
      ..moveTo(centerX - startWidth / 2, y)
      ..lineTo(centerX + startWidth / 2, y)
      ..lineTo(centerX + endWidth / 2, size.height)
      ..lineTo(centerX - endWidth / 2, size.height)
      ..close();
    final basePath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final path = Path.combine(PathOperation.difference, basePath, lightPath);

    canvas.clipPath(path);
    canvas.drawPath(path, _foregroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
