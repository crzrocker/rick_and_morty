
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/characters_response.dart';


class NetworkManager{

  Future<CharactersResponse?> getCharactersPage(int currentPageNumber) async {
    CharactersResponse? charactersResponse;
    try {
      final response = await http.get(
        Uri.parse('https://rickandmortyapi.com/api/character?page=$currentPageNumber'),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        charactersResponse = CharactersResponse.fromJson(item);// Mapping json response to our data model
      } else {
        debugPrint('Error Occurred');
      }
    } catch (e) {
      debugPrint('Error Occurred: $e');
    }
    return charactersResponse;
  }

}