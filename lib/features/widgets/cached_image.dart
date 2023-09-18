import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weath_app/common/resources/app_assets.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key? key,
    required this.image,
    this.height = 80,
    this.width = 80,
  }) : super(key: key);

  final String image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: image,
      width: width,
      height: height,
      placeholder: (context, url) => Image.asset(
        ImagesAssets.mainLogo,
        height: height,
        width: width,
        color: Colors.black,
      ),
      errorWidget: (context, url, error) => Image.asset(
        ImagesAssets.mainLogo,
        height: height,
        width: width,
      ),
    );
  }
}
