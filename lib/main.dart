import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:requests_inspector/requests_inspector.dart';
import 'package:weath_app/common/app/my_app.dart';

void main() async {
  runApp(
    ProviderScope(
      child: RequestsInspector(
        enabled: kDebugMode,
        child: Consumer(
          builder: (context, ref, child) {
            return const MyApp();
          },
        ),
      ),
    ),
  );
}
