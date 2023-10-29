import 'package:ficha_3det_victory/src/app.dart';
import 'package:ficha_3det_victory/src/char_sheet/entities/char_sheet.dart';
import 'package:ficha_3det_victory/src/char_sheet/ui/create_char/create_char_page.dart';
import 'package:ficha_3det_victory/src/char_sheet/ui/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/splash",
  debugLogDiagnostics: kDebugMode,
  routes: [
    GoRoute(
      name: 'splash',
      path: '/splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/sheets',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          name: 'create',
          path: 'create',
          builder: (context, state) => const CreateCharPage(),
        ),
        GoRoute(
          name: 'edit',
          path: 'edit/:id',
          builder: (context, state) {
            assert(state.extra != null && state.extra is CharSheet);

            return CreateCharPage(editingChar: state.extra as CharSheet);
          },
        ),
      ],
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
