import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    const placeholder = Center(
      child: Icon(Icons.person_outline, size: 48, color: Colors.white38),
    );

    if (url.isEmpty) return placeholder;

    return Image.network(
      url,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
          ),
        );
      },
      errorBuilder: (_, __, ___) => placeholder,
    );
  }
}