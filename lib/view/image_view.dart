import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

String loadImage(String path) {
  return "images/$path";
}

class CircleImage extends StatelessWidget {
  final String _imageUrl;
  final double width;
  final double height;
  final String placeholder;

  CircleImage(this._imageUrl,
      {this.width, this.height, this.placeholder = "icon_aout_us.png"});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular((width + height) / 2)),
        child:
            CacheNetImage(_imageUrl, width, height, placeholder: placeholder));
  }
}

class CacheNetImage extends StatelessWidget {
  final String _imageUrl;
  final double width;
  final double height;
  final String placeholder;

  CacheNetImage(this._imageUrl, this.width, this.height,
      {this.placeholder = "icon_aout_us.png"});

  @override
  Widget build(BuildContext context) {
    /// 说明是本地图片直接加载
    if (!_imageUrl.startsWith("http")) {
      return Image.asset(
        loadImage(_imageUrl),
        width: width,
        height: height,
      );
    }

    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: _imageUrl,
      errorWidget: (context, url, error) => Icon(Icons.error),
      placeholder: (context, url) {
        return Image.asset(
          loadImage(placeholder),
          width: width,
          height: height,
        );
      },
    );
  }
}
