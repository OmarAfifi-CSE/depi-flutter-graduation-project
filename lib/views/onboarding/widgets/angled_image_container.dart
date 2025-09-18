import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SimpleAngledPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final double borderRadius;
  final double bottomRadius;
  final double angleHeight;

  SimpleAngledPainter({
    required this.borderColor,
    required this.borderWidth,
    required this.backgroundColor,
    this.borderRadius = 16.0,
    this.bottomRadius = 15.0,
    this.angleHeight = 30.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Paint للـ Border
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    Path path = Path();

    path.moveTo(borderRadius, 0);

    path.lineTo(size.width - borderRadius, 0);

    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
    );

    path.lineTo(size.width, size.height - angleHeight - bottomRadius);

    path.arcToPoint(
      Offset(size.width - bottomRadius, size.height - angleHeight),
      radius: Radius.circular(bottomRadius),
    );

    path.lineTo(bottomRadius, size.height - bottomRadius);

    path.arcToPoint(
      Offset(0, size.height - bottomRadius * 2),
      radius: Radius.circular(bottomRadius),
    );

    path.lineTo(0, borderRadius);

    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
    );

    path.close();

    canvas.drawPath(path, fillPaint);

    // رسم الـ Border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Path getPath(Size size) {
    Path path = Path();

    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(size.width, size.height - angleHeight - bottomRadius);
    path.arcToPoint(
      Offset(size.width - bottomRadius, size.height - angleHeight),
      radius: Radius.circular(bottomRadius),
    );
    path.lineTo(bottomRadius, size.height - bottomRadius);
    path.arcToPoint(
      Offset(0, size.height - bottomRadius * 2),
      radius: Radius.circular(bottomRadius),
    );
    path.lineTo(0, borderRadius);
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
    );
    path.close();

    return path;
  }
}

class SimpleAngledContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double bottomRadius;
  final double angleHeight;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const SimpleAngledContainer({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
    this.borderRadius = 16.0,
    this.bottomRadius = 15.0,
    this.angleHeight = 30.0,
    this.width,
    this.height,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: CustomPaint(
        painter: SimpleAngledPainter(
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          borderWidth: borderWidth,
          borderRadius: borderRadius,
          bottomRadius: bottomRadius,
          angleHeight: angleHeight,
        ),
        child: Container(
          padding: padding ?? EdgeInsets.all(16.r),
          child: child,
        ),
      ),
    );
  }
}

class AngledImageClipper extends CustomClipper<Path> {
  final double borderRadius;
  final double bottomRadius;
  final double angleHeight;

  AngledImageClipper({
    this.borderRadius = 16.0,
    this.bottomRadius = 15.0,
    this.angleHeight = 30.0,
  });

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(borderRadius, 0);
    path.lineTo(size.width - borderRadius, 0);
    path.arcToPoint(
      Offset(size.width, borderRadius),
      radius: Radius.circular(borderRadius),
    );
    path.lineTo(size.width, size.height - angleHeight - bottomRadius);
    path.arcToPoint(
      Offset(size.width - bottomRadius, size.height - angleHeight),
      radius: Radius.circular(bottomRadius),
    );
    path.lineTo(bottomRadius, size.height - bottomRadius);
    path.arcToPoint(
      Offset(0, size.height - bottomRadius * 2),
      radius: Radius.circular(bottomRadius),
    );
    path.lineTo(0, borderRadius);
    path.arcToPoint(
      Offset(borderRadius, 0),
      radius: Radius.circular(borderRadius),
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AngledImageContainer extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double bottomRadius;
  final double angleHeight;
  final BoxFit fit;
  final EdgeInsetsGeometry? margin;

  const AngledImageContainer({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderColor = Colors.grey,
    this.borderWidth = 2.0,
    this.borderRadius = 16.0,
    this.bottomRadius = 15.0,
    this.angleHeight = 30.0,
    this.fit = BoxFit.cover,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Stack(
        children: [
          ClipPath(
            clipper: AngledImageClipper(
              borderRadius: borderRadius,
              bottomRadius: bottomRadius,
              angleHeight: angleHeight,
            ),
            child: Image.network(
              imageUrl,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (context, error, stackTrace) => Container(
                width: width,
                height: height,
                color: Colors.grey[300],
                child: const Icon(Icons.error, color: Colors.grey),
              ),
            ),
          ),
          // Border
          CustomPaint(
            painter: SimpleAngledPainter(
              backgroundColor: Colors.transparent,
              borderColor: borderColor,
              borderWidth: borderWidth,
              borderRadius: borderRadius,
              bottomRadius: bottomRadius,
              angleHeight: angleHeight,
            ),
            size: Size(width ?? double.infinity, height ?? double.infinity),
          ),
        ],
      ),
    );
  }
}
