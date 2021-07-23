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
  static const _startWidth = 0.2;
  static const _endWidth = 0.7;

  final _foregroundPaint = Paint()..color = Colors.black;
  final _backgroundPaint = Paint()
    ..color = Colors.yellow.withAlpha((255 * 0.4).toInt());

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, _backgroundPaint);

    final centerX = size.width / 2;
    final startWidth = size.width * _startWidth;
    final endWidth = size.width * _endWidth;
    final lightPath = Path()
      ..moveTo(centerX - startWidth / 2, 0)
      ..lineTo(centerX + startWidth / 2, 0)
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
