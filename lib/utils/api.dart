import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sklv/models/character.dart';
import 'package:sklv/utils/api_exception.dart';

class Api {
  static Future<String?> fetch(
    String page,
  ) async {
    try {
      final response = await http.get(Uri.parse(page));

      if (response.statusCode == 200) {
        String responseBody = response.body;
        return responseBody;
      } else {
        throw ApiException.defaultError();
      }
    } on IOException {
      throw ApiException.connectionError();
    }
  }

  static Future<Character?> fetchOne(int id) async {
    try {
      final response = await http
          .get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));

      if (response.statusCode == 200) {
        String responseBody = response.body;
        Character one = Character.fromJson(responseBody);
        return one;
      } else {
        throw ApiException.defaultError();
      }
    } on IOException {
      throw ApiException.connectionError();
    }
  }
}
