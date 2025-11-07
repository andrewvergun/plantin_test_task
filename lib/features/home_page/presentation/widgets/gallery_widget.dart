import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
        padding: const EdgeInsets.all(8),
        itemCount: images.length + (isLoading ? 1 : 0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Show loading indicator at the end
          if (index == images.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              images[index]['download_url'],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.error),
                );
              },
            ),
          );
        },
      ),
    );
  }
}