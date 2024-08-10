import 'package:flutter/material.dart';
import 'package:time_tracking_app/core/constants/image_constants.dart';

class AssetImageWidget extends StatelessWidget {
  final String assetPath;
  final double? height;
  final double? width;
  final BoxFit? boxFit;

  const AssetImageWidget({
    super.key,
    required this.assetPath,
    this.height,
    this.width,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Image.asset(
      height: height ?? deviceSize.height,
      width: width ?? deviceSize.width,
      assetPath,
      fit: boxFit ?? BoxFit.cover,
    );
  }
}
