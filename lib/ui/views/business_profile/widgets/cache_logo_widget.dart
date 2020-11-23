import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheLogoWidget extends StatelessWidget {
  final String imageUrl;
  const CacheLogoWidget({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.grey,
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 35.0,
        backgroundImage: imageProvider,
      ),
    );
  }
}
