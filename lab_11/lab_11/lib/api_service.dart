import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Надсилання даних на сервер
  Future<void> sendData(Map<String, String> data, String endpoint) async {
    final String url = 'https://MFGost.requestcatcher.com'; // URL вашого сервісу

    try {
      // Виконуємо POST-запит
      final response = await _dio.post(
        url,
        data: data,
      );
      print('Response: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
