import 'package:flutter/material.dart';
import 'dart:math';

class WindDirectionIcon extends StatelessWidget {
  final double angleDegree;
  final double size;
  final Color color;

  const WindDirectionIcon({
    super.key,
    required this.angleDegree,
    this.size = 40,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _WindPainter(angleDegree, color),
    );
  }
}

class _WindPainter extends CustomPainter {
  final double angleDegree;
  final Color color;

  _WindPainter(this.angleDegree, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Cercle de base (optionnel)
    final paintCircleBase = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius, paintCircleBase);

    // Points cardinaux (N, S, E, W)
    final paintCardinal = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 4; i++) {
      final theta = (2 * pi * i) / 4;
      final x = center.dx + radius * cos(theta);
      final y = center.dy + radius * sin(theta);
      canvas.drawCircle(Offset(x, y), 2, paintCardinal);
    }

    // Points intermédiaires (plus petits)
    final paintIntermediate = Paint()
      ..color = color.withOpacity(0.4)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 8; i++) {
      if (i % 2 == 1) { // Points entre les cardinaux
        final theta = (2 * pi * i) / 8;
        final x = center.dx + radius * 0.85 * cos(theta);
        final y = center.dy + radius * 0.85 * sin(theta);
        canvas.drawCircle(Offset(x, y), 1, paintIntermediate);
      }
    }

    // Flèche direction vent (plus stylée)
    final rad = (angleDegree - 90) * pi / 180;
    final arrowLength = radius * 0.7;
    final arrowEnd = Offset(
      center.dx + arrowLength * cos(rad),
      center.dy + arrowLength * sin(rad),
    );

    // Ligne principale de la flèche
    final paintArrow = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, arrowEnd, paintArrow);

    // Pointe de flèche (triangle)
    final arrowHeadLength = size.width * 0.15;
    final arrowHeadAngle = pi / 6; // 30 degrés

    final arrowPoint1 = Offset(
      arrowEnd.dx - arrowHeadLength * cos(rad - arrowHeadAngle),
      arrowEnd.dy - arrowHeadLength * sin(rad - arrowHeadAngle),
    );

    final arrowPoint2 = Offset(
      arrowEnd.dx - arrowHeadLength * cos(rad + arrowHeadAngle),
      arrowEnd.dy - arrowHeadLength * sin(rad + arrowHeadAngle),
    );

    final arrowPath = Path()
      ..moveTo(arrowEnd.dx, arrowEnd.dy)
      ..lineTo(arrowPoint1.dx, arrowPoint1.dy)
      ..lineTo(arrowPoint2.dx, arrowPoint2.dy)
      ..close();

    final paintArrowHead = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(arrowPath, paintArrowHead);

    // Centre (point de départ)
    final paintCenter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 3, paintCenter);
  }

  @override
  bool shouldRepaint(_WindPainter oldDelegate) =>
      oldDelegate.angleDegree != angleDegree || oldDelegate.color != color;
}

// Widget de démonstration
class WindDirectionDemo extends StatefulWidget {
  @override
  _WindDirectionDemoState createState() => _WindDirectionDemoState();
}

class _WindDirectionDemoState extends State<WindDirectionDemo> {
  double _windDirection = 45.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('Direction du Vent'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  WindDirectionIcon(
                    angleDegree: _windDirection,
                    size: 100,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    '${_windDirection.round()}°',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _getWindDirectionText(_windDirection),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Slider(
                value: _windDirection,
                min: 0,
                max: 360,
                divisions: 360,
                activeColor: Colors.white,
                inactiveColor: Colors.white30,
                onChanged: (value) {
                  setState(() {
                    _windDirection = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getWindDirectionText(double angle) {
    if (angle >= 337.5 || angle < 22.5) return 'Nord';
    if (angle >= 22.5 && angle < 67.5) return 'Nord-Est';
    if (angle >= 67.5 && angle < 112.5) return 'Est';
    if (angle >= 112.5 && angle < 157.5) return 'Sud-Est';
    if (angle >= 157.5 && angle < 202.5) return 'Sud';
    if (angle >= 202.5 && angle < 247.5) return 'Sud-Ouest';
    if (angle >= 247.5 && angle < 292.5) return 'Ouest';
    if (angle >= 292.5 && angle < 337.5) return 'Nord-Ouest';
    return '';
  }
}