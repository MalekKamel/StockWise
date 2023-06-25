// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_module/screens/main/main_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_module/shared/core/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: App.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff3886e0),
        useMaterial3: true,
      ),
      routes: {'/': (context) => const MainScreen()},
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
