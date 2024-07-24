import 'character.dart';

class CharactersResponse{

  int count = 0;
  int pages = 0;
  String? next;
  String? prev;
  List<Character> charactersList = [];

  CharactersResponse.fromJson(Map<String, dynamic> json) {
    count = json['info']['count'] ?? 0;
    pages = json['info']['pages'] ?? 0;
    next = json['info']['next'];
    prev = json['info']['prev'];
    final charactersData = json['results'] as List<dynamic>?;
    charactersList = charactersData != null
        ? charactersData.map((element) =>
            Character.fromJson(element as Map<String, dynamic>)).toList()
        : [];

  }

}