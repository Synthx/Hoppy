import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:hoppy/widget/widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

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

  void _onPicturePathChanged(String? path) {
    _beerImagePath = path;
    widget.form.control('picturePath').value = path;
  }

  @override
  void initState() {
    super.initState();
    _beerImagePath = widget.form.control('picturePath').value;
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
          SelectPicture(
            picturePath: _beerImagePath,
            onPictureChanged: (picture) => _onPicturePathChanged(picture),
          ),
        ],
      ),
    );
  }
}
