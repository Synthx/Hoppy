import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';

class SelectUploadPictureAction extends StatelessWidget {
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
            title: const Text('Séléctionner une photo'),
            leading: const Icon(Icons.image),
            onTap: () => _selectAction(context, UploadPictureAction.GALLERY),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
            ),
          ),
          ListTile(
            title: const Text('Prendre une photo'),
            leading: const Icon(Icons.add_a_photo),
            onTap: () => _selectAction(context, UploadPictureAction.CAMERA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: 5,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 0),
          ListTile(
            title: Center(
              child: const Text('Annuler'),
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
