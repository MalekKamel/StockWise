// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_module/screens/main/main_screen.dart';
import 'package:flutter_module/screens/profile_/profile_screen.dart';
import 'package:flutter_module/screens/search/search_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff3886e0),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const MainScreen()
      },
    );
  }
}
