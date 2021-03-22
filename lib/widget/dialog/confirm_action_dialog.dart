import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

class ConfirmActionDialog extends StatelessWidget {
  final String title;
  final String content;
  final String action;

  const ConfirmActionDialog({
    required this.title,
    required this.content,
    required this.action,
  });

  void _closeDialog(BuildContext context, [bool? result]) {
    context.pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 16,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const Divider(height: 0),
            ListTile(
              onTap: () => _closeDialog(context, true),
              title: Center(
                child: Text(
                  action,
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            ),
            const Divider(height: 0),
            ListTile(
              onTap: () => _closeDialog(context),
              title: Center(
                child: const Text('Annuler'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
