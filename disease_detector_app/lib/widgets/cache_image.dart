import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String? imageUrl;
  const CacheImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return imageUrl == null
        ? Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/blank_image.jpg'),
                  fit: BoxFit.cover),
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            placeholder: (context, url) =>
                const CircularProgressIndicator(strokeWidth: 2),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          );
  }
}
