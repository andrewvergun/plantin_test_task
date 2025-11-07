import 'package:dio/dio.dart';

class GalleryService {
  final Dio dio = Dio();

  Future<List<dynamic>> getImages({int page = 1, int limit = 30}) async {
    String baseUrl = 'https://picsum.photos/v2/list';
    try {
      final Response response = await dio.get(
        baseUrl,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      print('Error fetching images: $e');
      return [];
    }
  }
}