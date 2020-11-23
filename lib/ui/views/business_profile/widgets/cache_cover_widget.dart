import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheCoverWidget extends StatelessWidget {
  final String imageUrl;
  const CacheCoverWidget({
    Key key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) => Container(
        width: MediaQuery.of(context).size.width,
        height: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.grey,
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.of(context).size.width,
        height: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: imageProvider,
          ),
        ),
      ),
    );
  }
}
