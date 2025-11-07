import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../pages/view_image_page.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget({
    super.key,
    required this.images,
    required this.onEndOfPage,
    required this.isLoading,
  });

  final List<dynamic> images;
  final VoidCallback onEndOfPage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: onEndOfPage,
      scrollOffset: 100,
      child: GridView.builder(
        itemCount: images.length + (isLoading ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == images.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final image = images[index]['download_url'];
          final isLocal = image.toString().startsWith('/');

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: GestureDetector(
              onTap: () {
                context.push(
                  '/${ViewImagePage.path}/$index',
                  extra: {'images': images, 'initialIndex': index},
                );
              },
              child: Image(
                image: isLocal
                    ? FileImage(File(image))
                    : NetworkImage(image) as ImageProvider,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
