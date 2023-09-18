import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weath_app/common/resources/app_assets.dart';

class AnimatedImage extends StatefulWidget {
  final String imageUrl;

  const AnimatedImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<AnimatedImage> createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => Image.asset(
        ImagesAssets.mainLogo,
        fit: BoxFit.contain,
      ),
      // errorWidget: (context, url, error) => Icon(Icons.error),
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: FractionalOffset(_animation.value, 0),
    );
  }
}
