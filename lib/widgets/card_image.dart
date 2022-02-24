import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double width;
  final double radius;
  final BoxShape shape;
  final BoxFit boxFit;

  const CardImage(
      {Key? key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.shape = BoxShape.rectangle,
      this.boxFit = BoxFit.cover,
      this.radius = 16})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl == "") {
      return Container(
          height: height,
          width: width,
          decoration: shape == BoxShape.rectangle
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: const Color(0xffC4C4C4))
              : BoxDecoration(shape: shape, color: const Color(0xffC4C4C4)));
    } else {
      return CachedNetworkImage(
        imageUrl: "$imageUrl",
        imageBuilder: (context, imageProvider) => Container(
          height: height,
          width: width,
          decoration: shape == BoxShape.rectangle
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: boxFit,
                  ),
                )
              : BoxDecoration(
                  shape: shape,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: boxFit,
                  ),
                ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            height: height,
            width: width,
            decoration: shape == BoxShape.rectangle
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    color: const Color(0xffC4C4C4))
                : BoxDecoration(shape: shape, color: const Color(0xffC4C4C4))),
        errorWidget: (context, url, error) => Container(
          height: height,
          width: width,
          decoration: shape == BoxShape.rectangle
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: const Color(0xffC4C4C4))
              : BoxDecoration(shape: shape, color: const Color(0xffC4C4C4)),
        ),
      );
    }
  }
}
