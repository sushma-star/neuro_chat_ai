import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiService {
  Future<String> sendPrompt(String prompt) async {
    try {
      // 1️⃣ Log the prompt being sent
      print("=== GPT Request ===");
      print("Prompt: $prompt");

      // 2️⃣ Send POST request
      final response = await http.post(
        Uri.parse(ApiConstants.baseUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${ApiConstants.apiKey}",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": prompt}
          ]
        }),
      );

      // 3️⃣ Log HTTP status
      print("HTTP Status Code: ${response.statusCode}");

      // 4️⃣ Log full response body
      print("Response Body: ${response.body}");

      // 5️⃣ Parse and return GPT message if successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data["choices"][0]["message"]["content"];
        print("GPT Response: $content");
        return content;
      } else {
        print("Error: ${response.body}");
        throw Exception('Failed GPT API: ${response.body}');
      }
    } catch (e) {
      // 6️⃣ Log any exception
      print("Exception in sendPrompt: $e");
      rethrow;
    }
  }
}
