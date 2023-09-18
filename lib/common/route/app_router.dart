import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/common/route/route_strings.dart';
import 'package:weath_app/features/home_screen/presentation/view/home_screen.dart';

part 'app_router.g.dart';

@riverpod
BuildContext context(ContextRef ref) {
  return ref
      .watch(appRouterProvider)
      .routerDelegate
      .navigatorKey
      .currentContext!;
}

@riverpod
Raw<GoRouter> appRouter(AppRouterRef ref) {
  return GoRouter(
    redirect: (context, state) {
      log('router going to:${state.uri.toString()} with query params: ${state.uri.queryParameters}');
      return null;
    },
    routes: <GoRoute>[
      GoRoute(
        path: RouteStrings.instance.initial,
        name: '/',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
