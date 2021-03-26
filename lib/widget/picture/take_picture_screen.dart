import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hoppy/core/core.dart';
import 'package:permission_handler/permission_handler.dart';

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
  CameraLensDirection? _cameraDirection;
  FlashMode _currentFlashMode = FlashMode.off;
  XFile? picture;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final isGranted = await Permission.camera.isGranted;

    if (!isGranted) {
      await context.showActionDialog(
        title: AppLocalizations.of(context)!.need_permission,
        content: AppLocalizations.of(context)!.need_permission_camera,
        icon: Text(
          '📷',
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
        action: AppLocalizations.of(context)!.open_settings,
        onAction: () => openAppSettings(),
      );
      context.pop();
    } else if (cameras.isNotEmpty) {
      final camera = cameras.first;
      await _onCameraSelected(
        camera: camera,
      );
    } else {
      await context.showNotificationDialog(
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.take_picture_no_camera,
        icon: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 32,
        ),
      );
      context.pop();
    }
  }

  Future<void> _onCameraSelected({
    required CameraDescription camera,
  }) async {
    if (_cameraController != null) {
      await _cameraController!.dispose();
    }

    final controller = CameraController(
      camera,
      ResolutionPreset.veryHigh,
    );
    _cameraController = controller;
    _cameraDirection = camera.lensDirection;
    await controller.initialize();
    try {
      await controller.setFlashMode(_currentFlashMode);
    } on CameraException catch (e) {
      // flash mode doesn't exist on front camera
      if (e.code == 'setFlashModeFailed') {
        await controller.setFlashMode(FlashMode.off);
        _currentFlashMode = FlashMode.off;
      }
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  void _changeCamera() async {
    final cameras = await availableCameras();
    CameraLensDirection direction;
    switch (_cameraDirection) {
      case CameraLensDirection.front:
        direction = CameraLensDirection.back;
        break;
      case CameraLensDirection.back:
        direction = CameraLensDirection.front;
        break;
      default:
        throw '$_cameraDirection not handled';
    }
    final nextCamera = cameras.where((e) => e.lensDirection == direction).first;
    await _onCameraSelected(
      camera: nextCamera,
    );
  }

  void _takePicture() async {
    final controller = _cameraController;
    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }

    final file = await controller.takePicture();
    setState(() {
      picture = file;
    });
  }

  void _changeFlashMode() async {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return;
    }

    FlashMode mode;
    switch (_currentFlashMode) {
      case FlashMode.off:
        mode = FlashMode.torch;
        break;
      case FlashMode.torch:
        mode = FlashMode.auto;
        break;
      case FlashMode.auto:
        mode = FlashMode.off;
        break;
      default:
        throw '$_currentFlashMode not handled';
    }
    await controller.setFlashMode(mode);
    setState(() {
      _currentFlashMode = mode;
    });
  }

  void _resetPicture() {
    setState(() {
      picture = null;
    });
  }

  void _validatePicture() {
    context.pop(picture!.path);
  }

  void _closeScreen() {
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _onCameraSelected(
        camera: cameraController.description,
      );
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
        title: Text(AppLocalizations.of(context)!.take_picture),
        leading: IconButton(
          onPressed: () => _closeScreen(),
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: picture != null
                ? _picturePreviewWidget()
                : _CameraPreview(
                    cameraController: _cameraController,
                  ),
          ),
          _footerWidget(),
        ],
      ),
    );
  }

  Widget _picturePreviewWidget() {
    return Container(
      width: double.infinity,
      child: Image.file(
        File(
          picture!.path,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _footerWidget() {
    final iconSize = 28.0;

    return Container(
      height: 160,
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
          if (picture == null)
            IconButton(
              icon: const Icon(Icons.flip_camera_android),
              onPressed: () => _changeCamera(),
              iconSize: iconSize,
            ),
          if (picture == null)
            GestureDetector(
              onTap: () => _takePicture(),
              child: Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.6),
                    width: 8,
                  ),
                ),
              ),
            ),
          if (picture == null)
            _FlashModeButton(
              flashMode: _currentFlashMode,
              lensDirection: _cameraDirection,
              onTap: () => _changeFlashMode(),
            ),
          if (picture != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => _validatePicture(),
              iconSize: iconSize,
            ),
          if (picture != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () => _resetPicture(),
              iconSize: iconSize,
            ),
        ],
      ),
    );
  }
}

class _FlashModeButton extends StatelessWidget {
  final FlashMode flashMode;
  final CameraLensDirection? lensDirection;
  final VoidCallback? onTap;

  _FlashModeButton({
    required this.flashMode,
    this.lensDirection,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (lensDirection == CameraLensDirection.front) {
      return Container();
    }

    IconData iconData;
    switch (flashMode) {
      case FlashMode.torch:
        iconData = Icons.flash_on;
        break;
      case FlashMode.off:
        iconData = Icons.flash_off;
        break;
      default:
        iconData = Icons.flash_auto;
        break;
    }
    return IconButton(
      icon: Icon(iconData),
      onPressed: onTap,
      iconSize: 28,
    );
  }
}

class _CameraPreview extends StatelessWidget {
  final CameraController? cameraController;

  const _CameraPreview({
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    final controller = cameraController;
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * controller.value.aspectRatio;
    if (scale < 1) {
      scale = 1 / scale;
    }

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(
          controller,
        ),
      ),
    );
  }
}
