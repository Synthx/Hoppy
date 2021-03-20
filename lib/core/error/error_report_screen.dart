import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';
import 'package:share/share.dart';

class ErrorReportScreen extends StatelessWidget {
  static MaterialPageRoute route(ErrorReport report) => MaterialPageRoute(
        builder: (_) => ErrorReportScreen(report: report),
      );

  final ErrorReport report;

  const ErrorReportScreen({
    required this.report,
  });

  void _closeDialog(BuildContext context) {
    context.pop();
  }

  void _shareReport() {
    Share.share('Lol', subject: 'test');
  }

  @override
  Widget build(BuildContext context) {
    final items = report.stackTrace.toString().split('\n');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapport'),
        leading: IconButton(
          onPressed: () => _closeDialog(context),
          icon: Icon(Icons.chevron_left),
        ),
        actions: [
          IconButton(
            onPressed: () => _shareReport(),
            icon: Icon(Icons.ios_share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('------- ERROR -------'),
            Text('${report.error.runtimeType}'),
            Text('------- DATE -------'),
            Text('${report.time}'),
            Text('------- PLATFORM -------'),
            Text('${report.platform}'),
            Text('------- DEVICE -------'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: report.deviceInfo.length,
              itemBuilder: (context, index) {
                var key = report.deviceInfo.keys.elementAt(index);
                var value = report.deviceInfo.values.elementAt(index);
                return Text('$key: $value');
              },
            ),
            Text('------- PACKAGE -------'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: report.packageInfo.length,
              itemBuilder: (context, index) {
                var key = report.packageInfo.keys.elementAt(index);
                var value = report.packageInfo.values.elementAt(index);
                return Text('$key: $value');
              },
            ),
            Text('------- STACKTRACE -------'),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Text('${items[index]}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
