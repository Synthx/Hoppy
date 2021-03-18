import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/store/store.dart';

class DarkModeTile extends StatefulWidget {
  @override
  State createState() => DarkModeTileState();
}

class DarkModeTileState extends State<DarkModeTile> {
  bool selected = false;

  void onValueChanged(bool value) {
    context.read<SettingsCubit>().darkModeChanged(value);
    setState(() {
      selected = value;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      selected = context.read<SettingsCubit>().state.value.darkMode ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 64,
      child: Center(
        child: ListTile(
          title: const Text('Mode nuit'),
          trailing: CupertinoSwitch(
            value: selected,
            onChanged: (value) => onValueChanged(value),
          ),
          onTap: () => onValueChanged(!selected),
        ),
      ),
    );
  }
}
