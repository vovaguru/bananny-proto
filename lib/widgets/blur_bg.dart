import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredBg extends StatelessWidget {
  const BlurredBg({super.key, required this.child, required this.blurFactor});

  final Widget child;
  final double blurFactor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurFactor, sigmaY: blurFactor),
          child: child),
    );
  }
}
