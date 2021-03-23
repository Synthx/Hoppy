import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/data/data.dart';
import 'package:hoppy/widget/widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class SelectPicture extends StatefulWidget {
  final String? picturePath;
  final Function(String?) onPictureChanged;
  final double size;

  const SelectPicture({
    required this.picturePath,
    required this.onPictureChanged,
    this.size = 72,
  });

  @override
  State createState() => _SelectPictureState();
}

class _SelectPictureState extends State<SelectPicture> {
  String? _picturePath;

  Future<void> _openPictureActionDialog() async {
    final action = await showModalBottomSheet<UploadPictureAction?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => SelectUploadPictureAction(
        havePicture: _picturePath != null,
      ),
    );

    if (action != null) {
      String? picturePath;
      switch (action) {
        case UploadPictureAction.CAMERA:
          picturePath = await _openTakePictureScreen();
          break;
        case UploadPictureAction.GALLERY:
          picturePath = await _openPictureGallery();
          break;
        case UploadPictureAction.DELETE:
          widget.onPictureChanged(null);
          setState(() {
            _picturePath = null;
          });
          break;
      }

      if (picturePath != null) {
        widget.onPictureChanged(picturePath);
        setState(() {
          _picturePath = picturePath;
        });
      }
    }
  }

  Future<String?> _openPictureGallery() async {
    final picker = ImagePicker();

    try {
      final picture = await picker.getImage(
        source: ImageSource.gallery,
      );
      if (picture != null) {
        return picture.path;
      }
    } on PlatformException catch (e) {
      if (e.code == 'photo_access_denied') {
        await context.showActionDialog(
          title: AppLocalizations.of(context)!.need_permission,
          content: AppLocalizations.of(context)!.need_permission_gallery,
          icon: Text(
            '📷',
            style: TextStyle(fontSize: 50, color: Colors.black),
          ),
          action: AppLocalizations.of(context)!.open_settings,
          onAction: () => openAppSettings(),
        );
      } else {
        rethrow;
      }
    }
  }

  Future<String?> _openTakePictureScreen() async {
    final picturePath = await Navigator.push<String?>(
      context,
      TakePictureScreen.route(),
    );

    return picturePath;
  }

  @override
  void initState() {
    super.initState();
    _picturePath = widget.picturePath;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPictureActionDialog(),
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor.withOpacity(0.5),
          ),
          borderRadius: BorderRadius.circular(widget.size / 2),
        ),
        child: _picturePath == null
            ? const Center(
                child: Icon(Icons.camera_alt),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(widget.size),
                child: Image.file(
                  File(_picturePath!),
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
