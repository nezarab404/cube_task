import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? height;
  final double? width;
  final bool isDirectional;

  const SvgIcon({
    super.key,
    required this.icon,
    this.color,
    this.height,
    this.width,
    this.isDirectional = false,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
      width: width,
      matchTextDirection: isDirectional,
      fit: BoxFit.contain,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.dstIn) : null,
    );
  }
}
