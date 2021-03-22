import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/store/store.dart';

class NameInputTile extends StatefulWidget {
  @override
  State createState() => NameInputTileState();
}

class NameInputTileState extends State<NameInputTile> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void onNameChanged(BuildContext context, String value) {
    BlocProvider.of<SettingsCubit>(context).nameChanged(value);
  }

  void focusOnField() {
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    _controller.value = _controller.value.copyWith(
      text: context.read<SettingsCubit>().state.value.name ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 64,
      child: Center(
        child: ListTile(
          title: const Text('Prénom'),
          trailing: Container(
            width: 160,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.end,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              onSubmitted: (value) => onNameChanged(context, value),
            ),
          ),
          onTap: () => focusOnField(),
        ),
      ),
    );
  }
}
