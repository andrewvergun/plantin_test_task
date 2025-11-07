import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class GalleryService {
  final Dio dio = Dio();
  final List<Map<String, dynamic>> _localImages = [];

  Future<List<dynamic>> getImages({int page = 1, int limit = 30}) async {
    const String baseUrl = 'https://picsum.photos/v2/list';
    try {
      final Response response = await dio.get(
        baseUrl,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      final List<dynamic> apiImages = response.data as List<dynamic>;
      return [..._localImages, ...apiImages];
    } on DioException catch (e) {
      print('Error fetching images: $e');
      return _localImages;
    }
  }

  Future<void> pickAndAddImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _localImages.insert(0, {
        'download_url': image.path,
        'id': 'local_${DateTime.now().millisecondsSinceEpoch}',
      });
      print('Added local image: ${image.path}');
    } else {
      print('No image selected.');
    }
  }
}
