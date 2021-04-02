import 'package:flutter/material.dart';
import 'package:hoppy/screens/main/search/search.dart';
import 'package:hoppy/widget/widget.dart';

class SearchViewHeader extends StatefulWidget with PreferredSizeWidget {
  @override
  State createState() => _SearchViewHeaderState();

  @override
  Size get preferredSize => Size.fromHeight(70);
}

class _SearchViewHeaderState extends State<SearchViewHeader> {
  bool _inputFocused = false;

  void _openFilterDialog() {
    Navigator.push(
      context,
      SearchBeerFilterDialog.route(),
    );
  }

  void _onKeywordChanged(String? value) {}

  void _onInputFocused(bool focused) {
    setState(() {
      _inputFocused = focused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 70,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: SearchInput(
              onValueChanged: (value) => _onKeywordChanged(value),
              onFocused: (focused) => _onInputFocused(focused),
            ),
          ),
          IconButton(
            icon: Icon(Icons.tune),
            onPressed: () => _openFilterDialog(),
          ),
        ],
      ),
    );
  }
}
