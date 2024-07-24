import 'package:flutter/material.dart';
import 'package:rick_and_morty/models/character.dart';
import 'package:rick_and_morty/models/characters_response.dart';
import 'package:rick_and_morty/network/network_manager.dart';

import '../screens/character_details_screen.dart';

enum DataState {
  loading,
  dataReady,
  onError
}

class ListProvider extends ChangeNotifier {
  ListProvider();

  int _currentPageNumber = 1;
  int _totalPages = 1;
  DataState _dataState = DataState.loading;
  DataState get dataState => _dataState;

  CharactersResponse? data;
  List<Character> charactersList = [];

  final ScrollController _scrollController = ScrollController();
  get scrollController => _scrollController;

  Future<void> getData({bool isRefresh = false}) async {
    _dataState = DataState.loading;
    if(isRefresh){
      notifyListeners();
    }
    data = await NetworkManager()
        .getCharactersPage(isRefresh ? 1 : _currentPageNumber);
    if (data != null && data!.charactersList.isNotEmpty) {
      if (isRefresh) {
        charactersList = [];
        _currentPageNumber = 1;
      }

      charactersList.addAll(data!.charactersList);
      _totalPages = data!.pages;

      _dataState = DataState.dataReady;
    } else {
      _dataState = DataState.onError;
    }
    notifyListeners();
  }

  Future<void> refreshData() async {
    await getData(isRefresh: true);
  }

  void loadMoreData() {
    if (_totalPages-1 > _currentPageNumber) {
      _currentPageNumber++;
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      getData();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool canLoadMoreData() {
    return _totalPages > _currentPageNumber;
  }

  onItemTap(BuildContext context, Character item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CharacterDetailsScreen(item)),
    );
  }
}
