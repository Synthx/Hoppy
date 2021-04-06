import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/generated/l10n.dart';
import 'package:hoppy/store/store.dart';

class DeleteDataButton extends StatelessWidget {
  void _deleteData(BuildContext context) async {
    final result = await context.showConfirmActionDialog(
      title: Localization.of(context).settings_delete_data,
      content: Localization.of(context).settings_delete_data_content,
      action: Localization.of(context).delete,
    );

    if (result != null && result == true) {
      context.read<SettingsCubit>().deleteData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: ListTile(
          onTap: () => _deleteData(context),
          title: Center(
            child: Text(
              Localization.of(context).settings_delete_data,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
