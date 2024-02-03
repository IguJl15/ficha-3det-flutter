import 'dart:ui';

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:ficha_3det_victory/src/localization/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'routes.dart';
import 'settings/settings_controller.dart';
import 'shared/assets_constants/splash_assets.dart';
import 'shared/extensions/context_extensions.dart';
import 'shared/theme/color_schemes.g.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          restorationScopeId: 'app',
          scrollBehavior: const MyCustomScrollBehavior(),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', ''),
            Locale('en', ''),
          ],
          onGenerateTitle: (BuildContext context) => AppLocalizations.of(context).home_appTitle,
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          themeMode: settingsController.themeMode,
          routerConfig: router,
        );
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen(
      backgroundColor: context.theme.colorScheme.background,
      splashScreenBody: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(splashImage), Text(context.l!.splash_hello)],
        ),
      ),
      asyncNavigationCallback: () async {
        Future.delayed(const Duration(seconds: 2)).then(
          (value) => context.goNamed("home"),
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  const MyCustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.mouse,
      }..addAll(super.dragDevices);
}
