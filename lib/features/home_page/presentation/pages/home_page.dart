import 'package:flutter/material.dart';
import 'package:plantin_test_task/common/widgets/common_filled_button.dart';
import 'package:plantin_test_task/features/home_page/data/services/gallery_service.dart';
import 'package:plantin_test_task/features/home_page/presentation/widgets/gallery_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const path = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GalleryService _galleryService = GalleryService();
  final List<dynamic> _images = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final newImages = await _galleryService.getImages(page: _currentPage);

      setState(() {
        if (newImages.isEmpty) {
          _hasMore = false;
        } else {
          _images.clear();
          _images.addAll(newImages);
          _currentPage++;
        }
      });
    } catch (e) {
      print('Error loading images: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addPhoto() async {
    await _galleryService.pickAndAddImage();
    final updatedImages = await _galleryService.getImages(page: 1);
    setState(() => _images
      ..clear()
      ..addAll(updatedImages));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CommonFilledButton(
        onPressed: _addPhoto,
        icon: Icons.add_a_photo,
        text: 'Add photo',
      ),
      body: _images.isEmpty && _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _images.isEmpty
          ? const Center(child: Text('No images available'))
          : GalleryWidget(
        images: _images,
        onEndOfPage: _loadImages,
        isLoading: _isLoading,
      ),
    );
  }
}
