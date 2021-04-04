import 'package:flutter/material.dart';

class SearchBeerFilterDialog extends StatefulWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (_) => SearchBeerFilterDialog(),
        fullscreenDialog: true,
      );

  @override
  _SearchBeerFilterDialogState createState() => _SearchBeerFilterDialogState();
}

class _SearchBeerFilterDialogState extends State<SearchBeerFilterDialog> {
  void _closeDialog() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtre'),
        leading: IconButton(
          onPressed: () => _closeDialog(),
          icon: const Icon(Icons.clear),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: ElevatedButton(
            onPressed: () => _closeDialog(),
            child: const Text('Rechercher'),
          ),
        ),
      ),
    );
  }
}
