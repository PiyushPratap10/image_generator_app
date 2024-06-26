import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';

class PromptRepo {
  static Future<Uint8List?> generateImage(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      Map<String, dynamic> headers = {
        'Authorization':
            'Bearer vk-API_KEY'
      };
      Map<String, dynamic> payload = {
        'prompt': prompt,
        'style_id': '122',
        'aspect_ratio': '1:1',
        'cfg': '1',
        'seed': '1',
        'high_res_results': '0'
      };
      FormData formData = FormData.fromMap(payload);

      Dio dio = Dio();
      dio.options = BaseOptions(
        headers: headers,
        responseType: ResponseType.bytes
      );

      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        Uint8List uint8List = Uint8List.fromList(response.data);
        return uint8List;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
