import 'package:flutter/material.dart';
import 'package:hoppy/widget/widget.dart';

extension BuildContextExtension on BuildContext {
  Future<void> showSuccessDialog({
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

  Future<void> showLoadingDialog() {
    return showGeneralDialog(
      context: this,
      barrierDismissible: false,
      pageBuilder: (context, _, __) => LoadingDialog(),
    );
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }
}
