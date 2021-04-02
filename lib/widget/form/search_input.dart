import 'package:flutter/material.dart';
import 'package:hoppy/generated/l10n.dart';

class SearchInput extends StatefulWidget {
  final Function(String?) onValueChanged;
  final Function(bool)? onFocused;

  const SearchInput({
    required this.onValueChanged,
    this.onFocused,
  });

  @override
  State createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool showCancelButton = false;
  bool showResetButton = false;

  void _cancelAction() {
    _controller.text = '';
    _focus.unfocus();
  }

  void _resetValue() {
    _controller.text = '';
    if (!_focus.hasFocus) {
      _focus.requestFocus();
    }
  }

  void _onFieldSubmitted(String value) {
    widget.onValueChanged(value);
  }

  void _onFocusChanged() {
    if (widget.onFocused != null) {
      widget.onFocused!(_focus.hasFocus);
    }
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(
                  Icons.search,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focus,
                    autocorrect: false,
                    enableSuggestions: false,
                    onSubmitted: (value) => _onFieldSubmitted(value),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: Localization.of(context).search_hint,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (_controller.value.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => _resetValue(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: Icon(
                        Icons.clear,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (showCancelButton)
          TextButton(
            onPressed: () => _cancelAction(),
            child: Text(
              Localization.of(context).cancel,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
      ],
    );
  }
}
