import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:logging/logging.dart';
import 'package:package_info/package_info.dart';

class ErrorHandler {
  final void Function() runAppFunction;

  final _logger = Logger('ErrorHandler');
  final _deviceInfo = <String, dynamic>{};
  final _packageInfo = <String, dynamic>{};

  static GlobalKey<NavigatorState>? _navigatorKey;
  static late ErrorHandler _instance;

  static GlobalKey<NavigatorState>? get navigatorKey {
    return _navigatorKey;
  }

  ErrorHandler({
    required this.runAppFunction,
    GlobalKey<NavigatorState>? navigatorKey,
  }) {
    _configure(navigatorKey);
  }

  void _configure(GlobalKey<NavigatorState>? navigatorKey) async {
    _logger.info('configure error handler');
    _instance = this;
    if (navigatorKey != null) {
      _navigatorKey = navigatorKey;
    } else {
      _navigatorKey = GlobalKey<NavigatorState>();
    }

    _addErrorHandler();
    await _loadDeviceInformation();
    await _loadApplicationInformation();

    _logger.info('running application');
    runAppFunction();
  }

  void _addErrorHandler() {
    FlutterError.onError = (FlutterErrorDetails detail) async {
      _onError(detail.exception, detail.stack, detail: detail);
    };
  }

  Future<void> _loadDeviceInformation() async {
    _logger.info('load device information');

    final deviceInfoPlugin = DeviceInfoPlugin();
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        await _loadIosDeviceInformation(deviceInfoPlugin);
        break;
      default:
        _logger
            .warning('unhandled device information for $defaultTargetPlatform');
    }
  }

  Future<void> _loadIosDeviceInformation(DeviceInfoPlugin plugin) async {
    try {
      final information = await plugin.iosInfo;

      _deviceInfo['model'] = information.model;
      _deviceInfo['systemVersion'] = information.systemVersion;
      _deviceInfo['localizedModel'] = information.localizedModel;
      _deviceInfo['utsnameVersion'] = information.utsname.version;
      _deviceInfo['utsnameRelease'] = information.utsname.release;
      _deviceInfo['utsnameSysname'] = information.utsname.sysname;
    } catch (e) {
      _logger.warning('unable to load iOS device information : $e');
    }
  }

  Future<void> _loadApplicationInformation() async {
    _logger.info('load application information');
    try {
      final packageInformation = await PackageInfo.fromPlatform();

      _packageInfo['version'] = packageInformation.version;
      _packageInfo['buildNumber'] = packageInformation.buildNumber;
      _packageInfo['packageName'] = packageInformation.packageName;
    } catch (e) {
      _logger.warning('unable to load package information : $e');
    }
  }

  void _onError(
    Object error,
    StackTrace? stackTrace, {
    FlutterErrorDetails? detail,
  }) async {
    _logger.warning('handling error ${error.runtimeType}');
    if (detail?.silent == true) {
      _logger.info('skip handling error for ${error.runtimeType}');
      return;
    }

    // TODO: take application screenshot
    final report = ErrorReport(
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
      platform: defaultTargetPlatform,
      deviceInfo: _deviceInfo,
      packageInfo: _packageInfo,
    );

    final context = navigatorKey?.currentState?.overlay?.context;
    if (context != null) {
      _showErrorDialog(context, report);
    } else {
      _logger.warning('cannot retrieve current context');
    }
  }

  void _showErrorDialog(BuildContext context, ErrorReport report) async {
    await Future.delayed(Duration.zero);
    await showGeneralDialog(
      context: context,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => ErrorDialog(
        report: report,
      ),
    );
  }

  static void catchError(Object error, StackTrace? stackTrace) {
    _instance._onError(error, stackTrace);
  }
}
