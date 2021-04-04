import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/screens/main/search/search.dart';
import 'package:hoppy/store/store.dart';
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
          if (!_inputFocused)
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.tune),
                  onPressed: () => _openFilterDialog(),
                ),
                BlocBuilder<SearchCubit, SearchState>(
                  buildWhen: (prev, curr) =>
                      prev.filter.isEmpty() != curr.filter.isEmpty(),
                  builder: (context, state) {
                    if (state.filter.isEmpty()) {
                      return Container();
                    }

                    return Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
