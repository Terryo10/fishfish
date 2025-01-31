import 'dart:convert';
import 'dart:io';

import '../../static/app_urls.dart';
import '../../helpers/http_helper.dart';

class CharacterProvider {
  CharacterProvider();

  Future getCharacters(int page) async {
    try {
      final uri = Uri.parse(AppUrls.getCharacters)
          .replace(queryParameters: {'page': page.toString()});

      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.getUrl(uri);
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to fetch characters: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch characters: $e');
    }
  }

  Future getCharacter(int id) async {
    try {
      final uri = Uri.parse(AppUrls.getCharacter(id));

      HttpClient client = HttpHelper.getHttpClient();
      HttpClientRequest request = await client.getUrl(uri);
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to fetch character: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch character: $e');
    }
  }
}
