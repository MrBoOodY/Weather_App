import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weath_app/common/route/app_router.dart';

/// This widget is the root of your application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
    );
  }
}
