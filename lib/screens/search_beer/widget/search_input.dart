import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget with PreferredSizeWidget {
  final Function(String?) onValueChanged;

  const SearchInput({
    required this.onValueChanged,
  });

  @override
  Size get preferredSize => Size.fromHeight(48);

  @override
  State createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool showCancelButton = false;
  bool showResetButton = false;

  void _cancelAction() {
    _focus.unfocus();
  }

  void _resetValue() {
    _controller.text = '';
    _focus.unfocus();
    widget.onValueChanged(null);
  }

  void _onFieldSubmitted(String value) {
    widget.onValueChanged(value);
  }

  void _onFocusChanged() {
    setState(() {
      showCancelButton = _focus.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {
      showResetButton = _controller.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(Icons.search),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focus,
                      autocorrect: false,
                      enableSuggestions: false,
                      onSubmitted: (value) => _onFieldSubmitted(value),
                      decoration: const InputDecoration(
                        hintText: 'Paix Dieu, Anosteke, ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_controller.value.text.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _resetValue(),
                    ),
                ],
              ),
            ),
          ),
          if (showCancelButton)
            TextButton(
              onPressed: () => _cancelAction(),
              child: Text(
                'Annuler',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(),
              ),
            ),
        ],
      ),
    );
  }
}
