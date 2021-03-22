import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class UploadBeerPictureDialog extends StatefulWidget {
  static MaterialPageRoute<String?> route() => MaterialPageRoute<String?>(
        builder: (_) => UploadBeerPictureDialog(),
      );

  @override
  State createState() => _UploadBeerPictureDialogState();
}

class _UploadBeerPictureDialogState extends State<UploadBeerPictureDialog> {
  late CameraController _cameraController;
  late Future<void> _cameraInitialized;

  void _closeDialog() {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        leading: IconButton(
          onPressed: () => _closeDialog(),
          icon: const Icon(Icons.clear),
        ),
      ),
      body: FutureBuilder<void>(
        future: _cameraInitialized,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(
              _cameraController,
            ),
          );
        },
      ),
    );
  }
}
