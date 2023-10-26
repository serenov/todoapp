import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> sendPostRequest(
    Map<String, dynamic> requestBody, String route) async {
  // Loading the url from .env
  assert(dotenv.env['API_URL'] != null, "URL cannot be null");
  String url = dotenv.env['API_URL']!;

  try {
    final response = await http.post(
      Uri.parse(url + route),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    dynamic res = jsonDecode(response.body);

    if (response.statusCode >= 300) {
      throw Exception("SERVER ERROR: ${res["message"]}");
    }

    return res["message"];
  } catch (e) {
    rethrow;
  }
}
