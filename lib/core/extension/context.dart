import 'package:flutter/material.dart';
import 'package:hoppy/widget/widget.dart';

extension BuildContextExtension on BuildContext {
  Future<void> showNotificationDialog({
    required String title,
    required String content,
    required Widget icon,
  }) {
    return showGeneralDialog(
      context: this,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => SuccessNotificationDialog(
        title: title,
        content: content,
        icon: icon,
      ),
    );
  }

  Future<void> showActionDialog({
    required String title,
    required String content,
    required Widget icon,
    required String action,
    required VoidCallback onAction,
  }) {
    return showGeneralDialog(
      context: this,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => ActionDialog(
        icon: icon,
        title: title,
        content: content,
        action: action,
        onAction: onAction,
      ),
    );
  }

  Future<void> showLoadingDialog() {
    return showGeneralDialog(
      context: this,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => LoadingDialog(),
    );
  }

  Future<bool?> showConfirmActionDialog({
    required String title,
    required String content,
    required String action,
  }) {
    return showDialog<bool?>(
      context: this,
      barrierDismissible: false,
      builder: (context) => ConfirmActionDialog(
        title: title,
        content: content,
        action: action,
      ),
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
