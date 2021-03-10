import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UploadBeerPictureDialog extends StatefulWidget {
  static route() => MaterialPageRoute<String?>(
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

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;
    _cameraController = CameraController(camera, ResolutionPreset.high);
    _cameraInitialized = _cameraController.initialize();
    if (!mounted) {
      return;
    }
  }

  void _takePicture() async {
    await _cameraInitialized;

    final path = p.join(
      (await getTemporaryDirectory()).path,
      'temp_beer_picture.png',
    );
    print(path);
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
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
