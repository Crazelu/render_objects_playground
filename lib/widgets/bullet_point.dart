import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BulletPoint extends SingleChildRenderObjectWidget {
  BulletPoint(
      {Key? key,
      required this.child,
      this.bullet: BulletType.circleFilled,
      this.fillColor: const Color(0xff000000),
      this.outlineColor: const Color(0xff000000),
      this.radius: 5,
      this.thickness: 1.5})
      : super(key: key, child: child);

  final Widget child;
  final BulletType bullet;
  final Color fillColor;
  final Color outlineColor;
  final double radius;
  final double thickness;

  @override
  RenderBulletPoint createRenderObject(BuildContext context) {
    return RenderBulletPoint(
        bullet: bullet,
        fillColor: fillColor,
        outlineColor: outlineColor,
        radius: radius,
        thickness: thickness);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderBulletPoint renderObject) {
    renderObject
      ..bullet = bullet
      ..fillColor = fillColor
      ..outlineColor = outlineColor
      ..radius = radius
      ..thickness = thickness;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        EnumProperty('bullet', bullet, defaultValue: BulletType.circleFilled));
    properties.add(DoubleProperty("radius", radius, defaultValue: 5));
    properties.add(DoubleProperty('thickness', thickness, defaultValue: 1.5));
    properties.add(ColorProperty('fillColor', fillColor,
        defaultValue: const Color(0xff000000)));
    properties.add(ColorProperty('outlineColor', outlineColor,
        defaultValue: const Color(0xff000000)));
  }
}

class RenderBulletPoint extends RenderProxyBox {
  RenderBulletPoint(
      {RenderBox? child,
      required BulletType bullet,
      required Color fillColor,
      required Color outlineColor,
      required double radius,
      required double thickness})
      : _bullet = bullet,
        _fillColor = fillColor,
        _outlineColor = outlineColor,
        _radius = radius,
        _thickness = thickness,
        super(child);

  @override
  void performLayout() {
    super.performLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    Size childSize = child!.size;
    return constraints.constrain(Size(childSize.width, childSize.height));
  }

  BulletType _bullet;
  BulletType get bullet => _bullet;
  set bullet(BulletType val) {
    if (bullet == val) return;
    _bullet = val;
    markNeedsLayout();
  }

  Color _fillColor;
  Color get fillColor => _fillColor;
  set fillColor(Color val) {
    if (fillColor == val) return;
    _fillColor = val;
    markNeedsLayout();
  }

  Color _outlineColor;
  Color get outlineColor => _outlineColor;
  set outlineColor(Color val) {
    if (outlineColor == val) return;
    _outlineColor = val;
    markNeedsLayout();
  }

  double _radius;
  double get radius => _radius;
  set radius(double val) {
    if (radius == val) return;
    _radius = val;
    markNeedsLayout();
  }

  double _thickness;
  double get thickness => _thickness;
  set thickness(double val) {
    if (thickness == val) return;
    _thickness = val;
    markNeedsLayout();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    double childSize = child!.size.height;

    Offset verticalOffset = Offset(
        10,
        childSize *
            .5); //offset to align the bullet with the child widget's baseline
    Offset horizontalOffset =
        Offset(20, 0); //offsets the child widget from the bullet

    //paint brushes

    Paint filledBrush = Paint()
      ..strokeWidth = bullet == BulletType.dash ? 3 : thickness
      ..color = fillColor
      ..style = PaintingStyle.fill;

    Paint outlineBrush = Paint()
      ..color = outlineColor
      ..strokeWidth = bullet == BulletType.arrow ? 1.5 : thickness
      ..style = PaintingStyle.stroke;

    final canvas = context.canvas;
    canvas.save();

    //draw bullet

    switch (bullet) {
      case BulletType.circleFilled:
        canvas.drawCircle(offset + verticalOffset, radius, filledBrush);
        break;
      case BulletType.circleOutlined:
        canvas.drawCircle(offset + verticalOffset, radius, outlineBrush);
        break;
      case BulletType.squareFilled:
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromCircle(
                    center: offset + verticalOffset, radius: radius),
                Radius.zero),
            filledBrush);
        break;
      case BulletType.squareOutlined:
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromCircle(
                    center: offset + verticalOffset, radius: radius),
                Radius.zero),
            outlineBrush);
        break;
      case BulletType.dash:
        canvas.drawLine(
            Offset(offset.dx + 5, offset.dy) + verticalOffset,
            Offset(offset.dx + 5, offset.dy) + Offset(0, verticalOffset.dy),
            filledBrush);
        break;
      case BulletType.arrow:
      //straight line
        canvas.drawLine(
            Offset(offset.dx - 5, offset.dy) +
                Offset(horizontalOffset.dx - 10, verticalOffset.dy - 10),
            Offset(offset.dx - 5, offset.dy) +
                Offset(horizontalOffset.dx, verticalOffset.dy),
            outlineBrush);
        canvas.drawLine(
            Offset(offset.dx - 5, offset.dy) +
                Offset(horizontalOffset.dx - 10, verticalOffset.dy + 10),
            Offset(offset.dx - 5, offset.dy) +
                Offset(horizontalOffset.dx, verticalOffset.dy),
            outlineBrush);
        //slanting lines
        canvas.drawLine(
            offset + Offset(horizontalOffset.dx - 15, verticalOffset.dy - 10),
            offset + Offset(horizontalOffset.dx - 15, verticalOffset.dy),
            outlineBrush);
        canvas.drawLine(
            offset + Offset(horizontalOffset.dx - 15, verticalOffset.dy + 10),
            offset + Offset(horizontalOffset.dx - 15, verticalOffset.dy),
            outlineBrush);
        break;
      default:
        throw UnimplementedError("Canvas drawing for $bullet is uminplemented");
    }

    context.paintChild(child!, offset + horizontalOffset);
    canvas.restore();
  }
}

enum BulletType {
  circleFilled,
  circleOutlined,
  squareFilled,
  squareOutlined,
  dash,
  arrow
}
