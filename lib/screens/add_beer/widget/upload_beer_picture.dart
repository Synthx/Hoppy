import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../dialog/upload_beer_picture_dialog.dart';

class UploadBeerPicture extends StatefulWidget {
  final FormGroup form;

  const UploadBeerPicture({
    required this.form,
  });

  @override
  State createState() => _UploadBeerPictureState();
}

class _UploadBeerPictureState extends State<UploadBeerPicture> {
  String? _beerImagePath;

  void _openActionSheetPopup() async {
    // retrieve current cameras to see if some are available
    final cameras = (await availableCameras()).length > 0;
    // open modal
    final action = await showCupertinoModalPopup(
      context: context,
      builder: (_) => _UploadPictureActionSheet(
        availableCameras: cameras,
      ),
    );

    if (action != null) {
      switch (action) {
        case UploadPictureAction.CAMERA:
          await _openUploadPictureDialog();
          break;
        case UploadPictureAction.GALLERY:
          await _openPictureGallery();
          break;
      }
    }
  }

  Future<void> _openPictureGallery() async {
    final picker = ImagePicker();

    try {
      final picture = await picker.getImage(
        source: ImageSource.gallery,
      );
      if (picture != null) {
        final imagePath = picture.path;
        widget.form.control('picturePath').value = imagePath;
        setState(() {
          _beerImagePath = imagePath;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _openUploadPictureDialog() async {
    final imagePath = await Navigator.push<String?>(
      context,
      UploadBeerPictureDialog.route(),
    );
    if (imagePath != null) {
      widget.form.control('picturePath').value = imagePath;
      setState(() {
        _beerImagePath = imagePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: 20,
        top: 30,
      ),
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ajouter une photo',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Ajouter une photo pour reconnaitre cette bière plus facilement plus tard',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => _openActionSheetPopup(),
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(36),
              ),
              child: _beerImagePath == null
                  ? const Center(
                      child: Icon(Icons.camera_alt),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.file(
                        File(_beerImagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadPictureActionSheet extends StatelessWidget {
  final bool availableCameras;

  const _UploadPictureActionSheet({
    required this.availableCameras,
  });

  void _chooseAction(BuildContext context, UploadPictureAction action) {
    Navigator.pop(context, action);
  }

  void _closeSheet(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text('Importer une image'),
      actions: [
        if (availableCameras)
          CupertinoActionSheetAction(
            onPressed: () => _chooseAction(context, UploadPictureAction.CAMERA),
            child: const Text('Depuis l\'appareil photo'),
          ),
        CupertinoActionSheetAction(
          onPressed: () => _chooseAction(context, UploadPictureAction.GALLERY),
          child: const Text('Depuis la galerie'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => _closeSheet(context),
        isDefaultAction: true,
        child: const Text('Annuler'),
      ),
    );
  }
}
