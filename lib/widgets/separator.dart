import 'package:flutter/material.dart';

enum SeparatorType { horizontal, vertical }

enum SeparatorStyle { solid, dashed, dotted, none }

class Separator extends StatelessWidget {
  final SeparatorType type;
  final SeparatorStyle style;
  final double thickness;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double? width;
  final double? height;
  final double dashWidth;
  final double dashGap;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;

  const Separator({
    super.key,
    this.type = SeparatorType.horizontal,
    this.style = SeparatorStyle.solid,
    this.thickness = 1.0,
    this.color,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.width,
    this.height,
    this.dashWidth = 5.0,
    this.dashGap = 3.0,
    this.borderRadius,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ??
        Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05);

    Widget separator;

    switch (style) {
      case SeparatorStyle.solid:
        separator = _buildSolidSeparator(effectiveColor);
        break;
      case SeparatorStyle.dashed:
        separator = _buildDashedSeparator(effectiveColor);
        break;
      case SeparatorStyle.dotted:
        separator = _buildDottedSeparator(effectiveColor);
      case SeparatorStyle.none:
        separator = SizedBox(height: height, width: width);
        break;
    }

    return Padding(
      padding: margin,
      child: Padding(padding: padding, child: separator),
    );
  }

  Widget _buildSolidSeparator(Color effectiveColor) {
    return Container(
      width: type == SeparatorType.horizontal ? width : thickness,
      height: type == SeparatorType.vertical ? height : thickness,
      decoration: BoxDecoration(
        color: effectiveColor,
        borderRadius: borderRadius,
        boxShadow: shadow,
      ),
    );
  }

  Widget _buildDashedSeparator(Color effectiveColor) {
    return CustomPaint(
      size: Size(
        type == SeparatorType.horizontal
            ? (width ?? double.infinity)
            : thickness,
        type == SeparatorType.vertical
            ? (height ?? double.infinity)
            : thickness,
      ),
      painter: _DashedLinePainter(
        color: effectiveColor,
        thickness: thickness,
        dashWidth: dashWidth,
        dashGap: dashGap,
        isVertical: type == SeparatorType.vertical,
      ),
    );
  }

  Widget _buildDottedSeparator(Color effectiveColor) {
    return CustomPaint(
      size: Size(
        type == SeparatorType.horizontal
            ? (width ?? double.infinity)
            : thickness,
        type == SeparatorType.vertical
            ? (height ?? double.infinity)
            : thickness,
      ),
      painter: _DottedLinePainter(
        color: effectiveColor,
        thickness: thickness,
        dotRadius: thickness / 2,
        dotGap: dashGap,
        isVertical: type == SeparatorType.vertical,
      ),
    );
  }
}

// Dashed line painter
class _DashedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashGap;
  final bool isVertical;

  _DashedLinePainter({
    required this.color,
    required this.thickness,
    required this.dashWidth,
    required this.dashGap,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    double startPos = 0;
    final maxLength = isVertical ? size.height : size.width;

    while (startPos < maxLength) {
      if (isVertical) {
        canvas.drawLine(
          Offset(thickness / 2, startPos),
          Offset(thickness / 2, startPos + dashWidth),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(startPos, thickness / 2),
          Offset(startPos + dashWidth, thickness / 2),
          paint,
        );
      }
      startPos += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dotted line painter
class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dotRadius;
  final double dotGap;
  final bool isVertical;

  _DottedLinePainter({
    required this.color,
    required this.thickness,
    required this.dotRadius,
    required this.dotGap,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double startPos = 0;
    final maxLength = isVertical ? size.height : size.width;

    while (startPos < maxLength) {
      if (isVertical) {
        canvas.drawCircle(Offset(thickness / 2, startPos), dotRadius, paint);
      } else {
        canvas.drawCircle(Offset(startPos, thickness / 2), dotRadius, paint);
      }
      startPos += (dotRadius * 2) + dotGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
