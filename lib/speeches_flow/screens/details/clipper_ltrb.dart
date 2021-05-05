import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/utils/pair.dart';


class ClipperLTRB extends CustomClipper<Path> {
  final Pair<double, double> leftTop;
  final Pair<double, double> rightTop;
  final Pair<double, double> rightBottom;
  final Pair<double, double> leftBottom;

  ClipperLTRB({this.leftTop, this.rightTop, this.rightBottom, this.leftBottom});

  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(leftTop?.first ?? 0.0, leftTop?.second ?? 0.0);
    path.lineTo(rightTop?.first ?? size.width, rightTop?.second ?? 0.0);
    path.lineTo(rightBottom?.first ?? size.width, rightBottom?.second ?? size.height);
    path.lineTo(leftBottom?.first ?? 0.0, leftBottom?.second ?? size.height);
    path.lineTo(leftTop?.first ?? 0.0, leftTop?.second ?? 0.0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
