import 'dart:math';

import 'package:benji_vendor/src/providers/api_url.dart';
import 'package:benji_vendor/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String? url;
  final double imageHeight;
  const MyImage({super.key, this.url, this.imageHeight = 90});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return CachedNetworkImage(
      imageUrl: url == null ? '' : baseImage + url!,
      height: min(media.height, imageHeight),
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CupertinoActivityIndicator(color: kAccentColor)),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: kAccentColor),
    );
  }
}
