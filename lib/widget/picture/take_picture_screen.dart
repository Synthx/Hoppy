import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class TakePictureScreen extends StatefulWidget {
  static MaterialPageRoute<String?> route() => MaterialPageRoute(
        builder: (_) => TakePictureScreen(),
      );

  @override
  State createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  Future<void>? _cameraInitialized;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final camera = cameras.first;
      _cameraController = CameraController(
        camera,
        ResolutionPreset.high,
      );
      _cameraInitialized = _cameraController!.initialize();
      if (!mounted) {
        return;
      }
    } else {
      _cameraInitialized = Future.delayed(Duration.zero);
    }
  }

  void _closeScreen() {
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre une photo'),
        leading: IconButton(
          onPressed: () => _closeScreen(),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _CameraPreview(
              cameraController: _cameraController,
              cameraInitialized: _cameraInitialized,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding,
              bottom: kDefaultPadding + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.flash_auto),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraPreview extends StatelessWidget {
  final CameraController? cameraController;
  final Future<void>? cameraInitialized;

  const _CameraPreview({
    required this.cameraController,
    required this.cameraInitialized,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: cameraInitialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text(
                'Impossible de récupérer les informations de la caméra',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Center(
          child: Text('loading'),
        );
      },
    );
  }
}
