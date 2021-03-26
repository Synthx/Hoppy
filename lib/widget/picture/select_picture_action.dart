import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class SelectUploadPictureAction extends StatelessWidget {
  final bool havePicture;

  const SelectUploadPictureAction({
    required this.havePicture,
  });

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  void _selectAction(BuildContext context, UploadPictureAction action) {
    context.pop(action);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: max(
          kDefaultPadding,
          MediaQuery.of(context).padding.bottom,
        ),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(AppLocalizations.of(context)!.picture_action_gallery),
            leading: const Icon(Icons.image),
            onTap: () => _selectAction(context, UploadPictureAction.GALLERY),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
            ),
          ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.picture_action_camera),
            leading: const Icon(Icons.add_a_photo),
            onTap: () => _selectAction(context, UploadPictureAction.CAMERA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
            ),
          ),
          if (havePicture)
            ListTile(
              title: Text(AppLocalizations.of(context)!.picture_action_delete),
              leading: const Icon(Icons.clear),
              onTap: () => _selectAction(context, UploadPictureAction.DELETE),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
                vertical: 5,
              ),
            ),
          const SizedBox(height: 10),
          const Divider(height: 0),
          ListTile(
            title: Center(
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            onTap: () => _closeDialog(context),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
            ),
          ),
        ],
      ),
    );
  }
}
