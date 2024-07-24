import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/providers/list_provider.dart';
import 'package:rick_and_morty/widgets/row_widget.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  ListProvider? provider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Provider.of<ListProvider>(context, listen: false).getData());
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<ListProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Rick and Morty Family'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: switch (provider!.dataState) {
            DataState.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            DataState.onError => Center(
                child: InkWell(
                  onTap: () => provider!.refreshData(),
                  child: const Text(
                      'Something went wrong \n press here to refresh the data',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            DataState.dataReady => Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: provider!.refreshData,
                      child: ListView.builder(
                        controller: provider!.scrollController,
                        itemCount: provider!.charactersList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = provider!.charactersList[index];
                          debugPrint(item.toString());
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RowWidget(
                              name: item.name,
                              species: item.species,
                              gender: item.gender,
                              image: item.image,
                              onTap: () => provider!.onItemTap(context, item),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  if (provider!.canLoadMoreData())
                    InkWell(
                      onTap: provider!.loadMoreData,
                      child: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                          child: Text('Load more data')),
                    )
                ],
              ),
          }),
    );
  }
}
